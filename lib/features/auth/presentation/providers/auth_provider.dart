import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/api_service.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';


// State classes
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  const AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ApiService();
  final remoteDataSource = AuthRemoteDataSource(apiService: apiService);
  return AuthRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Auth notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthInitial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    state = const AuthLoading();
    try {
      final response = await _authRepository.signup(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      state = AuthAuthenticated(response.user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();
    try {
      final response = await _authRepository.login(
        email: email,
        password: password,
      );
      state = AuthAuthenticated(response.user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> sendOtp({
    required String phone,
  }) async {
    state = const AuthLoading();
    try {
      await _authRepository.sendOtp(phone: phone);
      state = const AuthUnauthenticated(); // OTP sent, waiting for verification
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    state = const AuthLoading();
    try {
      await _authRepository.verifyOtp(phone: phone, otp: otp);
      state = const AuthUnauthenticated(); // OTP verified, can proceed to login
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    state = const AuthLoading();
    try {
      await _authRepository.forgotPassword(email: email);
      state = const AuthUnauthenticated(); // Password reset email sent
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    state = const AuthLoading();
    try {
      await _authRepository.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      state = const AuthUnauthenticated(); // Password reset successful
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> getProfile() async {
    state = const AuthLoading();
    try {
      final user = await _authRepository.getProfile();
      state = AuthAuthenticated(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    state = const AuthLoading();
    try {
      final user = await _authRepository.updateProfile(
        name: name,
        email: email,
        phone: phone,
      );
      state = AuthAuthenticated(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    state = const AuthLoading();
    try {
      await _authRepository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      // Keep current user state
      if (state is AuthAuthenticated) {
        final currentUser = (state as AuthAuthenticated).user;
        state = AuthAuthenticated(currentUser);
      }
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> logout() async {
    state = const AuthLoading();
    try {
      await _authRepository.logout();
      state = const AuthUnauthenticated();
    } catch (e) {
      state = const AuthUnauthenticated(); // Always logout locally
    }
  }
}

// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

// Current user provider
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authProvider);
  if (authState is AuthAuthenticated) {
    return authState.user;
  }
  return null;
});

// Is authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState is AuthAuthenticated;
});