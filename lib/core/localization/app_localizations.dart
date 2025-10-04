import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static const supportedLocales = [
    Locale('en', ''),
    Locale('es', ''),
    Locale('fr', ''),
    Locale('de', ''),
    Locale('it', ''),
    Locale('pt', ''),
    Locale('ru', ''),
    Locale('ja', ''),
    Locale('ko', ''),
    Locale('zh', ''),
    Locale('ar', ''),
    Locale('hi', ''),
    Locale('bn', ''),
    Locale('ur', ''),
    Locale('tr', ''),
    Locale('th', ''),
    Locale('vi', ''),
    Locale('id', ''),
    Locale('ms', ''),
    Locale('tl', ''),
    Locale('nl', ''),
    Locale('sv', ''),
    Locale('da', ''),
    Locale('no', ''),
    Locale('fi', ''),
  ];

  // Localized strings
  String get appName => _getString('appName', 'Get Calley');
  String get continueText => _getString('continue', 'Continue');
  String get submit => _getString('submit', 'Submit');
  String get cancel => _getString('cancel', 'Cancel');
  String get save => _getString('save', 'Save');
  String get edit => _getString('edit', 'Edit');
  String get delete => _getString('delete', 'Delete');
  String get logout => _getString('logout', 'Logout');
  String get login => _getString('login', 'Login');
  String get signup => _getString('signup', 'Sign Up');
  String get forgotPassword => _getString('forgotPassword', 'Forgot Password?');
  String get resetPassword => _getString('resetPassword', 'Reset Password');
  String get resendOtp => _getString('resendOtp', 'Resend OTP');
  String get verifyOtp => _getString('verifyOtp', 'Verify OTP');
  String get startCalling => _getString('startCalling', 'Start Calling');
  String get syncData => _getString('syncData', 'Sync Data');
  String get sendLogs => _getString('sendLogs', 'Send Logs');
  String get cancelSubscription => _getString('cancelSubscription', 'Cancel Subscription');

  String get languageSelection => _getString('languageSelection', 'Select Language');
  String get createAccount => _getString('createAccount', 'Create Account');
  String get verifyYourNumber => _getString('verifyYourNumber', 'Verify Your Number');
  String get welcomeBack => _getString('welcomeBack', 'Welcome Back');
  String get dashboard => _getString('dashboard', 'Dashboard');
  String get settings => _getString('settings', 'Settings');
  String get profile => _getString('profile', 'Profile');
  String get changePassword => _getString('changePassword', 'Change Password');
  String get callingLists => _getString('callingLists', 'Calling Lists');
  String get gettingStarted => _getString('gettingStarted', 'Getting Started');
  String get gamification => _getString('gamification', 'Gamification');
  String get help => _getString('help', 'Help & Support');
  String get aboutUs => _getString('aboutUs', 'About Us');
  String get privacyPolicy => _getString('privacyPolicy', 'Privacy Policy');

  String get name => _getString('name', 'Name');
  String get email => _getString('email', 'Email');
  String get phone => _getString('phone', 'Phone Number');
  String get password => _getString('password', 'Password');
  String get confirmPassword => _getString('confirmPassword', 'Confirm Password');
  String get enterOtp => _getString('enterOtp', 'Enter OTP');
  String get oldPassword => _getString('oldPassword', 'Old Password');
  String get newPassword => _getString('newPassword', 'New Password');
  String get appLanguage => _getString('appLanguage', 'App Language');

  String get nameHint => _getString('nameHint', 'Enter your full name');
  String get emailHint => _getString('emailHint', 'Enter your email address');
  String get phoneHint => _getString('phoneHint', 'Enter your phone number');
  String get passwordHint => _getString('passwordHint', 'Enter your password');
  String get confirmPasswordHint => _getString('confirmPasswordHint', 'Confirm your password');
  String get otpHint => _getString('otpHint', 'Enter 6-digit OTP');

  String get agreeToTerms => _getString('agreeToTerms', 'I agree to the ');
  String get termsOfService => _getString('termsOfService', 'Terms of Service');
  String get and => _getString('and', ' and ');
  String get privacyPolicyText => _getString('privacyPolicyText', 'Privacy Policy');

  String get alreadyHaveAccount => _getString('alreadyHaveAccount', 'Already have an account? ');
  String get dontHaveAccount => _getString('dontHaveAccount', "Don't have an account? ");
  String get signIn => _getString('signIn', 'Sign In');
  String get signUpHere => _getString('signUpHere', 'Sign up here');
  String get or => _getString('or', 'OR');
  String get skip => _getString('skip', 'Skip');
  String get next => _getString('next', 'Next');
  String get done => _getString('done', 'Done');
  String get loading => _getString('loading', 'Loading...');
  String get pleaseWait => _getString('pleaseWait', 'Please wait...');
  String get noDataAvailable => _getString('noDataAvailable', 'No data available');
  String get pullToRefresh => _getString('pullToRefresh', 'Pull to refresh');
  String get retry => _getString('retry', 'Retry');
  String get yes => _getString('yes', 'Yes');
  String get no => _getString('no', 'No');
  String get confirm => _getString('confirm', 'Confirm');
  String get areYouSure => _getString('areYouSure', 'Are you sure?');
  String get logoutConfirmation => _getString('logoutConfirmation', 'Are you sure you want to logout?');
  String get deleteConfirmation => _getString('deleteConfirmation', 'Are you sure you want to delete?');

  String get goodMorning => _getString('goodMorning', 'Good Morning');
  String get goodAfternoon => _getString('goodAfternoon', 'Good Afternoon');
  String get goodEvening => _getString('goodEvening', 'Good Evening');
  String get totalCalls => _getString('totalCalls', 'Total Calls');
  String get successfulCalls => _getString('successfulCalls', 'Successful Calls');
  String get failedCalls => _getString('failedCalls', 'Failed Calls');
  String get conversionRate => _getString('conversionRate', 'Conversion Rate');
  String get callsToday => _getString('callsToday', 'Calls Today');
  String get weeklyStats => _getString('weeklyStats', 'Weekly Statistics');
  String get monthlyStats => _getString('monthlyStats', 'Monthly Statistics');

  // Error messages
  String get networkError => _getString('networkError', 'Network connection error');
  String get serverError => _getString('serverError', 'Server error occurred');
  String get unauthorizedError => _getString('unauthorizedError', 'Unauthorized access');
  String get validationError => _getString('validationError', 'Please check your input');
  String get somethingWentWrong => _getString('somethingWentWrong', 'Something went wrong');
  String get sessionExpired => _getString('sessionExpired', 'Session expired. Please login again');

  // Success messages
  String get loginSuccess => _getString('loginSuccess', 'Login successful');
  String get signupSuccess => _getString('signupSuccess', 'Account created successfully');
  String get otpSentSuccess => _getString('otpSentSuccess', 'OTP sent successfully');
  String get verificationSuccess => _getString('verificationSuccess', 'Verification successful');
  String get passwordResetSuccess => _getString('passwordResetSuccess', 'Password reset successful');
  String get profileUpdateSuccess => _getString('profileUpdateSuccess', 'Profile updated successfully');

  // Validation messages
  String get requiredField => _getString('requiredField', 'This field is required');
  String get invalidEmail => _getString('invalidEmail', 'Please enter a valid email');
  String get invalidPhone => _getString('invalidPhone', 'Please enter a valid phone number');
  String get passwordTooShort => _getString('passwordTooShort', 'Password must be at least 8 characters');
  String get passwordMismatch => _getString('passwordMismatch', 'Passwords do not match');
  String get invalidOtp => _getString('invalidOtp', 'Please enter a valid OTP');
  String get termsRequired => _getString('termsRequired', 'Please accept the terms and conditions');

  String _getString(String key, String defaultValue) {
    // For now, return default values. In a real app, you would load from JSON files
    // or use a localization package like flutter_localizations with ARB files.
    return defaultValue;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}