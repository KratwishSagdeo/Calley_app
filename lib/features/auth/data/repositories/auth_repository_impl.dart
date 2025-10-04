
import '../../../../core/config/app_config.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthResponseModel> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final response = await remoteDataSource.signup(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );

    // Save tokens and user data
    await AppConfig.storageService.saveToken(response.accessToken);
    await AppConfig.storageService.saveRefreshToken(response.refreshToken);
    await AppConfig.storageService.saveUserData(response.user.toJson().toString());

    return response;
  }

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.login(
      email: email,
      password: password,
    );

    // Save tokens and user data
    await AppConfig.storageService.saveToken(response.accessToken);
    await AppConfig.storageService.saveRefreshToken(response.refreshToken);
    await AppConfig.storageService.saveUserData(response.user.toJson().toString());

    return response;
  }

  @override
  Future<void> sendOtp({
    required String phone,
  }) async {
    await remoteDataSource.sendOtp(phone: phone);
  }

  @override
  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    await remoteDataSource.verifyOtp(phone: phone, otp: otp);
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    await remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    await remoteDataSource.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
  }

  @override
  Future<UserModel> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<UserModel> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    final user = await remoteDataSource.updateProfile(
      name: name,
      email: email,
      phone: phone,
    );

    // Update stored user data
    await AppConfig.storageService.saveUserData(user.toJson().toString());

    return user;
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await remoteDataSource.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } finally {
      // Always clear stored data even if logout API fails
      await AppConfig.storageService.clearAll();
    }
  }
}