import '../../../../core/services/api_service.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSource({required this.apiService});

  Future<AuthResponseModel> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await apiService.post(
        '/auth/signup',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );

      return AuthResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return AuthResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendOtp({
    required String phone,
  }) async {
    try {
      await apiService.post(
        '/auth/send-otp',
        data: {
          'phone': phone,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      await apiService.post(
        '/auth/verify-otp',
        data: {
          'phone': phone,
          'otp': otp,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      await apiService.post(
        '/auth/forgot-password',
        data: {
          'email': email,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await apiService.post(
        '/auth/reset-password',
        data: {
          'email': email,
          'otp': otp,
          'new_password': newPassword,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await apiService.get('/auth/profile');
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final response = await apiService.put(
        '/auth/profile',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await apiService.post(
        '/auth/change-password',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await apiService.post('/auth/logout');
    } catch (e) {
      rethrow;
    }
  }
}