import '../../data/models/auth_response_model.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
  });

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<void> sendOtp({
    required String phone,
  });

  Future<void> verifyOtp({
    required String phone,
    required String otp,
  });

  Future<void> forgotPassword({
    required String email,
  });

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });

  Future<UserModel> getProfile();

  Future<UserModel> updateProfile({
    required String name,
    required String email,
    required String phone,
  });

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<void> logout();
}