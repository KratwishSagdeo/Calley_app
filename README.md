# Calley Mobile App - Flutter Dashboard

A comprehensive Flutter mobile application dashboard for Calley, featuring advanced call management, user interface design, and seamless navigation experience.

## 📱 Overview

Calley is a professional calling and communication app designed to streamline phone communications with advanced features like calling list management, YouTube video integration, WhatsApp connectivity, and comprehensive settings management.

## ✨ Key Features

### 🏠 **Dual Interface System**
- **Landing Screen**: Welcome interface with personalized greeting and tutorial access
- **Calling Interface**: Professional dashboard with call management tools

### 📞 **Call Management**
- **Calling Lists Popup**: Interactive dialog displaying available calling lists
- **Contact Management**: View and manage calling lists with contact counts
- **Refresh Functionality**: Real-time list updates with user feedback

### 🎯 **Navigation System**
- **Bottom Navigation Bar**: 5-icon navigation system
  - Home (🏠): Return to landing screen
  - Dashboard (📊): Dashboard functionality
  - Play (▶️): Navigate to calling interface
  - Phone (📞): Open calling lists popup
  - Settings (⚙️): Access settings page

### 🎥 **Multimedia Integration**
- **YouTube Video Player**: Comprehensive video opening with multiple fallback URLs
- **Error Handling**: Graceful error management with user-friendly dialogs
- **Multiple Launch Modes**: App, browser, and platform-specific launching

### 💬 **Communication Features**
- **WhatsApp Integration**: Direct WhatsApp messaging with multiple URL fallbacks
- **Contact Support**: Quick access to customer support channels

### ☰ **Drawer Menu System**
- **Hamburger Menu**: Slide-out navigation drawer
- **User Profile**: Personalized user information display
- **Menu Options**:
  - Dashboard navigation
  - Getting Started guide
  - Data synchronization
  - Gamification features
  - Log management
  - Settings access
  - Help & Support
  - About Us
  - Privacy Policy
  - Subscription management
  - Secure logout with confirmation

### ⚙️ **Settings Management**
- **Profile Management**: Edit user information (name, email, phone)
- **App Preferences**: 
  - Language selection (25+ languages)
  - Notification settings
  - Dark mode toggle
  - Auto-dial configuration
- **Security Features**: Password change functionality
- **Calling Lists**: Manage calling lists and contacts

### 🎨 **Design & UI/UX**
- **Modern Design**: Clean, professional interface with Material Design principles
- **Responsive Layout**: Optimized for various screen sizes
- **Visual Feedback**: Loading states, animations, and user confirmations
- **Color Scheme**: Consistent blue-themed design with proper contrast
- **Typography**: Clear, readable fonts with proper hierarchy

## 🛠️ Technical Implementation

### **Architecture**
- **State Management**: Flutter Riverpod for reactive state management
- **Navigation**: MaterialPageRoute with custom navigation handlers
- **Responsiveness**: SafeArea and MediaQuery for device compatibility

### **Dependencies**
```yaml
dependencies:
  flutter_riverpod: ^2.4.0
  url_launcher: ^6.1.12
  go_router: ^10.1.2
  package_info_plus: ^4.1.0
```

### **Key Components**
- `DashboardPage`: Main dashboard widget with dual interface system
- `DrawerMenu`: Slide-out navigation menu
- `SettingsPage`: Comprehensive settings management
- `callingModeProvider`: State provider for interface switching

### **File Structure**
```
lib/
├── features/
│   ├── dashboard/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── dashboard_page.dart
│   │   │   └── widgets/
│   │   │       └── drawer_menu.dart
│   │   └── providers/
│   │       └── dashboard_provider.dart
│   ├── settings/
│   │   └── presentation/
│   │       └── pages/
│   │           └── settings_page.dart
│   └── auth/
│       └── presentation/
│           └── providers/
│               └── auth_provider.dart
├── core/
│   ├── constants/
│   │   └── app_colors.dart
│   └── localization/
│       └── app_localizations.dart
└── assets/
    └── images/
        └── calley2.png
```

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / VS Code
- Android/iOS development environment

### **Installation**
1. Clone the repository
```bash
git clone https://github.com/your-username/calley-mobile-app.git
cd calley-mobile-app
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure assets in `pubspec.yaml`
```yaml
flutter:
  assets:
    - assets/images/
```

4. Run the application
```bash
flutter run
```

## 📋 Usage Guide

### **Landing Screen**
1. View personalized welcome message
2. Access YouTube tutorial via video card
3. Navigate using bottom navigation bar
4. Use "Star Calling Now" button to begin calling

### **Calling Interface**
1. Access via play button (▶️) in navigation
2. View "Load Number to Call" information
3. Use hamburger menu (☰) for drawer navigation
4. Access calling lists via phone icon (📞)

### **Calling Lists Management**
1. Click phone icon (📞) in bottom navigation
2. View available calling lists with contact counts
3. Use refresh button to update lists
4. Select desired calling list for operations

### **Settings Configuration**
1. Navigate via settings icon (⚙️) or drawer menu
2. Update profile information
3. Configure app preferences
4. Manage security settings
5. Handle calling list preferences

## 🔧 Customization

### **Theming**
Modify colors in `core/constants/app_colors.dart`:
```dart
class AppColors {
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.blueAccent;
  // Add custom colors
}
```

### **Localization**
Add new languages in `core/localization/app_localizations.dart`:
```dart
final languages = {
  'en': 'English',
  'es': 'Español',
  // Add more languages
};
```

### **Calling Lists Data**
Update calling lists in `dashboard_page.dart`:
```dart
final List<Map<String, dynamic>> callingLists = [
  {'id': '1', 'name': 'Custom List', 'count': 100, 'status': 'active'},
  // Add more lists
];
```

## 🧪 Testing

### **Widget Testing**
```bash
flutter test
```

### **Integration Testing**
```bash
flutter drive --target=test_driver/app.dart
```

## 📱 Platform Support

- ✅ **Android**: Full support with Material Design
- ✅ **iOS**: Full support with Cupertino adaptations
- ⚠️ **Web**: Limited support (URL launcher constraints)
- ❌ **Desktop**: Not optimized

## 🔐 Security Features

- **Secure Authentication**: Riverpod-managed auth state
- **Password Management**: Secure password change functionality
- **Session Management**: Proper logout with state cleanup
- **Data Validation**: Input validation for user data

## 📊 Performance Optimizations

- **Lazy Loading**: On-demand widget creation
- **State Management**: Efficient Riverpod state updates
- **Memory Management**: Proper disposal of resources
- **Image Optimization**: Asset optimization with error handling

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and inquiries:
- **Email**: support@getcalley.com
- **Website**: https://app.getcalley.com
- **Documentation**: [API Documentation](https://docs.getcalley.com)

## 🎯 Future Roadmap

### **Version 2.0**
- [ ] Advanced calling analytics
- [ ] Voice recording functionality
- [ ] CRM integration
- [ ] Advanced filtering options

### **Version 2.1**
- [ ] AI-powered call insights
- [ ] Multi-language voice support
- [ ] Advanced reporting dashboard
- [ ] Team collaboration features

## 👥 Credits

- **Development**: Flutter Development Team
- **UI/UX Design**: Professional design team
- **Testing**: QA and Testing specialists
- **Project Management**: Agile development methodology

---

**Made with ❤️ using Flutter**

*Last updated: October 2025*
