import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../settings/presentation/pages/settings_page.dart';
// IMPORT YOUR EXISTING DRAWER MENU
import '../widgets/drawer_menu.dart';

// State provider to track if we're in calling mode
final callingModeProvider = StateProvider<bool>((ref) => false);

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  static const String youtubeUrl = 'https://www.youtube.com/watch?v=bP4U-L4EHcg&t=4s';
  static const String youtubeVideoId = 'bP4U-L4EHcg';

  // Sample calling lists - you can replace this with your actual data
  final List<Map<String, dynamic>> callingLists = [
    {'id': '1', 'name': 'Test List', 'count': 45, 'status': 'active'},
    {'id': '2', 'name': 'Client Prospects', 'count': 23, 'status': 'active'},
    {'id': '3', 'name': 'Follow Up List', 'count': 12, 'status': 'inactive'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _openWhatsApp() async {
    const phoneNumber = "+1234567890";
    final List<String> whatsappUrls = [
      "https://wa.me/$phoneNumber",
      "whatsapp://send?phone=$phoneNumber",
      "https://api.whatsapp.com/send?phone=$phoneNumber",
    ];

    bool success = false;
    for (String url in whatsappUrls) {
      try {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          success = true;
          break;
        }
      } catch (e) {
        continue;
      }
    }

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('WhatsApp is not installed on this device'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  Future<void> _openYouTubeVideo() async {
    // Try multiple YouTube URL patterns with more comprehensive approach
    final List<Map<String, String>> youtubeUrls = [
      // YouTube app deep links
      {'url': 'youtube://watch?v=$youtubeVideoId&t=4s', 'method': 'YouTube App'},
      {'url': 'vnd.youtube://$youtubeVideoId?t=4', 'method': 'YouTube Deep Link'},

      // Mobile YouTube URLs
      {'url': 'https://m.youtube.com/watch?v=$youtubeVideoId&t=4s', 'method': 'Mobile YouTube'},
      {'url': 'https://youtu.be/$youtubeVideoId?t=4', 'method': 'Short YouTube URL'},

      // Standard YouTube URLs
      {'url': youtubeUrl, 'method': 'Standard YouTube'},
      {'url': 'https://youtube.com/watch?v=$youtubeVideoId', 'method': 'YouTube without www'},
      {'url': 'https://www.youtube.com/embed/$youtubeVideoId?start=4', 'method': 'YouTube Embed'},
    ];

    bool success = false;
    String workingMethod = '';

    for (var urlData in youtubeUrls) {
      try {
        final uri = Uri.parse(urlData['url']!);

        // First check if the URL can be launched
        if (await canLaunchUrl(uri)) {
          // Try different launch modes
          try {
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
            success = true;
            workingMethod = urlData['method']!;
            break;
          } catch (e1) {
            // Try external non-browser application mode
            try {
              await launchUrl(
                uri,
                mode: LaunchMode.externalNonBrowserApplication,
              );
              success = true;
              workingMethod = urlData['method']!;
              break;
            } catch (e2) {
              // Try platform default
              try {
                await launchUrl(
                  uri,
                  mode: LaunchMode.platformDefault,
                );
                success = true;
                workingMethod = urlData['method']!;
                break;
              } catch (e3) {
                continue;
              }
            }
          }
        }
      } catch (e) {
        continue;
      }
    }

    if (success && mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Opening video via $workingMethod'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (!success && mounted) {
      // Show comprehensive error dialog with options
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Unable to Open Video'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Could not open the video automatically. Please try:'),
                const SizedBox(height: 12),
                const Text('1. Install the YouTube app'),
                const Text('2. Or copy the link below to open manually:'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    youtubeUrl,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Try to open in browser as last resort
                  launchUrl(
                    Uri.parse(youtubeUrl),
                    mode: LaunchMode.inAppBrowserView,
                  ).catchError((e) {
                    // If even browser fails, at least close the dialog
                  });
                },
                child: const Text('Open in Browser'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _launchWebPanel() async {
    const url = 'https://app.getcalley.com';
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch web panel';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open web panel: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _startCalling() {
    ref.read(callingModeProvider.notifier).state = true;
  }

  // NAVIGATE TO YOUR EXISTING SETTINGS PAGE
  void _navigateToSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      ),
    );
  }

  // SHOW CALLING LISTS POPUP
  void _showCallingListsPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'CALLING LISTS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Content
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Select Calling List section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Select Calling List',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Refresh action
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Calling lists refreshed'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.refresh, size: 16),
                              label: const Text('Refresh'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade600,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                textStyle: const TextStyle(fontSize: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Calling Lists
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: callingLists.length,
                            itemBuilder: (context, index) {
                              final list = callingLists[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list['name'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${list['count']} contacts',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        Icons.list,
                                        size: 18,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Close button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  // HANDLE BOTTOM NAVIGATION TAP WITH CALLING LISTS POPUP
  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0: // Home button
        ref.read(callingModeProvider.notifier).state = false;
        break;
      case 1: // Dashboard button
      // Could add dashboard functionality here
        break;
      case 2: // Play button - Navigate to calling interface
        ref.read(callingModeProvider.notifier).state = true;
        break;
      case 3: // Phone button - Show Calling Lists Popup
        _showCallingListsPopup();
        break;
      case 4: // Settings button - Navigate to Settings Page
        _navigateToSettings();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCallingMode = ref.watch(callingModeProvider);

    if (isCallingMode) {
      return _buildCallingInterface();
    } else {
      return _buildLandingScreen();
    }
  }

  Widget _buildLandingScreen() {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // ADD YOUR EXISTING DRAWER HERE
      drawer: const DrawerMenu(),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Welcome Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade600, Colors.blue.shade400],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello Swati',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Calley Personal',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Info Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'If you are here for the first time then ensure that you have uploaded the list to call from calley Web Panel hosted on https://app.getcalley.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Video Card - EXACT replica of the image
                      GestureDetector(
                        onTap: _openYouTubeVideo,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white,
                                    Colors.grey.shade100,
                                    Colors.grey.shade200,
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Cloud shapes in background
                                  Positioned(
                                    top: 20,
                                    left: 40,
                                    child: _buildCloudShape(60, 30),
                                  ),
                                  Positioned(
                                    top: 15,
                                    right: 30,
                                    child: _buildCloudShape(80, 40),
                                  ),
                                  Positioned(
                                    bottom: 25,
                                    left: 20,
                                    child: _buildCloudShape(70, 35),
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    right: 50,
                                    child: _buildCloudShape(90, 45),
                                  ),

                                  // Decorative rays/lines around the banner
                                  Positioned(
                                    top: 50,
                                    left: 60,
                                    child: Transform.rotate(
                                      angle: -0.3,
                                      child: _buildRayLine(Colors.yellow.shade400),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 80,
                                    child: Transform.rotate(
                                      angle: -0.1,
                                      child: _buildRayLine(Colors.orange.shade400),
                                    ),
                                  ),
                                  Positioned(
                                    top: 60,
                                    left: 100,
                                    child: Transform.rotate(
                                      angle: 0.2,
                                      child: _buildRayLine(Colors.yellow.shade400),
                                    ),
                                  ),

                                  // Right side rays
                                  Positioned(
                                    top: 50,
                                    right: 60,
                                    child: Transform.rotate(
                                      angle: 0.3,
                                      child: _buildRayLine(Colors.yellow.shade400),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    right: 80,
                                    child: Transform.rotate(
                                      angle: 0.1,
                                      child: _buildRayLine(Colors.orange.shade400),
                                    ),
                                  ),
                                  Positioned(
                                    top: 60,
                                    right: 100,
                                    child: Transform.rotate(
                                      angle: -0.2,
                                      child: _buildRayLine(Colors.yellow.shade400),
                                    ),
                                  ),

                                  // Main turquoise banner
                                  Center(
                                    child: Container(
                                      width: 240,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          // Banner background with ribbon effect
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF4DD0E1), // Turquoise/Teal color
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.15),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Banner fold effects (left)
                                          Positioned(
                                            left: -5,
                                            top: 0,
                                            bottom: 0,
                                            child: Container(
                                              width: 15,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF26C6DA), // Slightly darker teal
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft: Radius.circular(12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Banner fold effects (right)
                                          Positioned(
                                            right: -5,
                                            top: 0,
                                            bottom: 0,
                                            child: Container(
                                              width: 15,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF26C6DA), // Slightly darker teal
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomRight: Radius.circular(12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Text content
                                          Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '2 MINUTE',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal.shade800,
                                                    letterSpacing: 1.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  'CHALLENGE',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal.shade800,
                                                    letterSpacing: 1.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Red play button positioned exactly like in image
                                  Positioned(
                                    right: 85,
                                    bottom: 55,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.red.withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Extra spacing to ensure buttons are not covered
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Fixed Bottom Buttons
          Container(
            color: Colors.grey.shade50,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 34, // Extra padding for home indicator on iPhone
              top: 16,
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // WhatsApp Button
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _openWhatsApp,
                      icon: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Start Calling Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _startCalling,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Star Calling Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // BOTTOM NAVIGATION BAR WITH CALLING LISTS POPUP
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        currentIndex: 0, // Set home as default selected
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '',
          ),
        ],
        onTap: _handleBottomNavTap, // Use our custom handler with calling lists
      ),
    );
  }

  Widget _buildCloudShape(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }

  Widget _buildRayLine(Color color) {
    return Container(
      width: 3,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // CALLING INTERFACE WITH DRAWER
  Widget _buildCallingInterface() {
    return Scaffold(
      backgroundColor: Colors.white,
      // ADD YOUR EXISTING DRAWER HERE TOO
      drawer: const DrawerMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        // The hamburger menu (leading) will be automatically added by Flutter
        // when you add drawer: DrawerMenu() to the Scaffold
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black87,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // Welcome Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade600, Colors.blue.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello Swati',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Welcome to Calley!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Load Number to Call Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'LOAD NUMBER TO CALL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Main Content Card with Illustration
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Text content
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                height: 1.4,
                              ),
                              children: [
                                const TextSpan(text: 'Visit '),
                                TextSpan(
                                  text: 'https://app.getcalley.com',
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' to upload numbers that you wish to call using Calley Mobile App.',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Illustration Container
                          Container(
                            height: 200,
                            child: Stack(
                              children: [
                                // Background decorative elements
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.shade100,
                                          Colors.purple.shade100,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),

                                // Decorative leaves/plants
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: Container(
                                    width: 40,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade300,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  left: 10,
                                  child: Container(
                                    width: 25,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),

                                // Phone mockup
                                Positioned(
                                  bottom: 40,
                                  left: 100,
                                  child: Container(
                                    width: 80,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade900,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.blue.shade700,
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 20,
                                          color: Colors.blue.shade700,
                                          child: const Center(
                                            child: Text(
                                              '⋯ ⋯ ⋯',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white,
                                            child: Center(
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade500,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.download,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Main illustration - Man with laptop
                                Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: Container(
                                    width: 140,
                                    height: 180,
                                    child: Stack(
                                      children: [
                                        // Use the provided image path
                                        Positioned.fill(
                                          child: Image.asset(
                                            'assets/images/calley2.png',
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) {
                                              // Fallback illustration if image fails to load
                                              return _buildFallbackIllustration();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120), // Space for bottom buttons
                  ],
                ),
              ),
            ),
          ),

          // Fixed Bottom Buttons
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
              top: 8,
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // WhatsApp Button
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _openWhatsApp,
                      icon: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Start Calling Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _startCalling,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Star Calling Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // BOTTOM NAVIGATION BAR FOR CALLING INTERFACE WITH CALLING LISTS POPUP
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: false,
        currentIndex: 2, // Play button selected in calling mode
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '',
          ),
        ],
        onTap: _handleBottomNavTap, // Use our custom handler with calling lists
      ),
    );
  }

  // Fallback illustration if the image asset fails to load
  Widget _buildFallbackIllustration() {
    return Stack(
      children: [
        // Person silhouette
        Positioned(
          bottom: 40,
          right: 40,
          child: Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // Head
        Positioned(
          bottom: 110,
          right: 50,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange.shade300,
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Laptop
        Positioned(
          bottom: 60,
          right: 10,
          child: Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}