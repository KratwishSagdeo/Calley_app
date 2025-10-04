class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Get Calley';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = 'https://api.getcalley.com';
  static const String apiVersion = '/api/v1';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String languageCodeKey = 'language_code';
  static const String firstLaunchKey = 'first_launch';

  // Error Messages
  static const String networkError = 'Network connection error';
  static const String serverError = 'Server error occurred';
  static const String unauthorizedError = 'Unauthorized access';
  static const String validationError = 'Please check your input';
  static const String somethingWentWrong = 'Something went wrong';
  static const String sessionExpired = 'Session expired. Please login again';

  // Success Messages
  static const String loginSuccess = 'Login successful';
  static const String signupSuccess = 'Account created successfully';
  static const String otpSentSuccess = 'OTP sent successfully';
  static const String verificationSuccess = 'Verification successful';
  static const String passwordResetSuccess = 'Password reset successful';
  static const String profileUpdateSuccess = 'Profile updated successfully';

  // Validation Messages
  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String invalidPhone = 'Please enter a valid phone number';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordMismatch = 'Passwords do not match';
  static const String invalidOtp = 'Please enter a valid OTP';
  static const String termsRequired = 'Please accept the terms and conditions';

  // Button Texts
  static const String continueText = 'Continue';
  static const String submit = 'Submit';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String logout = 'Logout';
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';
  static const String resendOtp = 'Resend OTP';
  static const String verifyOtp = 'Verify OTP';
  static const String startCalling = 'Start Calling';
  static const String syncData = 'Sync Data';
  static const String sendLogs = 'Send Logs';
  static const String cancelSubscription = 'Cancel Subscription';

  // Screen Titles
  static const String languageSelection = 'Select Language';
  static const String createAccount = 'Create Account';
  static const String verifyYourNumber = 'Verify Your Number';
  static const String welcomeBack = 'Welcome Back';
  static const String dashboard = 'Dashboard';
  static const String settings = 'Settings';
  static const String profile = 'Profile';
  static const String changePassword = 'Change Password';
  static const String callingLists = 'Calling Lists';
  static const String gettingStarted = 'Getting Started';
  static const String gamification = 'Gamification';
  static const String help = 'Help & Support';
  static const String aboutUs = 'About Us';
  static const String privacyPolicy = 'Privacy Policy';

  // Form Labels
  static const String name = 'Name';
  static const String email = 'Email';
  static const String phone = 'Phone Number';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String enterOtp = 'Enter OTP';
  static const String oldPassword = 'Old Password';
  static const String newPassword = 'New Password';
  static const String appLanguage = 'App Language';

  // Hints
  static const String nameHint = 'Enter your full name';
  static const String emailHint = 'Enter your email address';
  static const String phoneHint = 'Enter your phone number';
  static const String passwordHint = 'Enter your password';
  static const String confirmPasswordHint = 'Confirm your password';
  static const String otpHint = 'Enter 6-digit OTP';

  // Checkboxes
  static const String agreeToTerms = 'I agree to the ';
  static const String termsOfService = 'Terms of Service';
  static const String and = ' and ';
  static const String privacyPolicyText = 'Privacy Policy';

  // Other Texts
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signIn = 'Sign In';
  static const String signUpHere = 'Sign up here';
  static const String or = 'OR';
  static const String skip = 'Skip';
  static const String next = 'Next';
  static const String done = 'Done';
  static const String loading = 'Loading...';
  static const String pleaseWait = 'Please wait...';
  static const String noDataAvailable = 'No data available';
  static const String pullToRefresh = 'Pull to refresh';
  static const String retry = 'Retry';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String confirm = 'Confirm';
  static const String areYouSure = 'Are you sure?';
  static const String logoutConfirmation = 'Are you sure you want to logout?';
  static const String deleteConfirmation = 'Are you sure you want to delete?';

  // Dashboard
  static const String goodMorning = 'Good Morning';
  static const String goodAfternoon = 'Good Afternoon';
  static const String goodEvening = 'Good Evening';
  static const String totalCalls = 'Total Calls';
  static const String successfulCalls = 'Successful Calls';
  static const String failedCalls = 'Failed Calls';
  static const String conversionRate = 'Conversion Rate';
  static const String callsToday = 'Calls Today';
  static const String weeklyStats = 'Weekly Statistics';
  static const String monthlyStats = 'Monthly Statistics';
}