import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';

/// HomeScreen widget, main landing page of the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// States class for HomeScreen
/// Handles menu animation, UI layout, and navigation
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _menuController; // Controls menu animation timing
  late Animation<double> _menuAnimation; // Smooth transition animation
  bool _isMenuOpen = false; // Track if side menu is open

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 300), // Menu open/close duration
      vsync: this,
    );

    // Apply easing curve for smooth animation
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    // Clean up controller when widget is disposed
    _menuController.dispose();
    super.dispose();
  }

  /// Toggles the side menu open/close
  void _toggleMenu() {
    print('Menu toggle tapped! Current state: $_isMenuOpen'); // Debug log
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _menuController.forward(); // Animate menu opening
      } else {
        _menuController.reverse(); // Animate menu closing
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AnnotatedRegion modifies system UI overlays (status bar, nav bar colors)
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Transparent status bar
          statusBarIconBrightness: Brightness.light, // White icons
          systemNavigationBarColor: Colors.transparent, // Transparent nav bar
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Container(
          // Background gradient defined in TartColors
          decoration: const BoxDecoration(
            gradient: TartColors.sunriseGradient,
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    /// Top Navigation Bar (logo + menu button)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // App Logo text
                          const Text(
                            'tart',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: TartColors.white,
                            ),
                          ),

                          // Menu toggle (hamburger → animated X)
                          GestureDetector(
                            onTap: _toggleMenu,
                            child: Container(
                              width: 48, // Increases touch area
                              height: 48,
                              alignment: Alignment.center,
                              child: AnimatedBuilder(
                                animation: _menuAnimation,
                                builder: (context, child) {
                                  // Animated hamburger/X icon
                                  return SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: Stack(
                                      children: [
                                        // Top bar → rotates to form top part of "X"
                                        Positioned(
                                          top: 7,
                                          left: 3,
                                          child: Transform.rotate(
                                            angle: _menuAnimation.value * 0.785398, // 45°
                                            child: _buildMenuBar(),
                                          ),
                                        ),
                                        // Middle bar → fades/scales out
                                        Positioned(
                                          top: 13,
                                          left: 3,
                                          child: Transform.scale(
                                            scale: 1 - _menuAnimation.value,
                                            child: _buildMenuBar(),
                                          ),
                                        ),
                                        // Bottom bar → rotates to form bottom part of "X"
                                        Positioned(
                                          top: 19,
                                          left: 3,
                                          child: Transform.rotate(
                                            angle: -_menuAnimation.value * 0.785398, // -45°
                                            child: _buildMenuBar(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Main Content Section
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),

                              // App title (large logo style)
                              const Text(
                                'tart',
                                style: TextStyle(
                                  fontSize: 72,
                                  fontWeight: FontWeight.bold,
                                  color: TartColors.white,
                                  height: 1.0,
                                  letterSpacing: -2,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Tagline
                              const Text(
                                'There\'s a restaurant there?!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: TartColors.white,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Main heading
                              const Text(
                                'Discover hidden restaurants\nin your area',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: TartColors.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Subheading
                              const Text(
                                'Curated by locals, verified by taste.\nFind your next favorite spot.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: TartColors.white,
                                  height: 1.5,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 48),

                              // Action Buttons (Get Started + Log Your Find)
                              Column(
                                children: [
                                  // Primary CTA button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // TODO: Navigate to restaurant discovery
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: TartColors.white,
                                        foregroundColor: TartColors.sunriseOrange,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                      ),
                                      child: const Text(
                                        'Get Started',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Secondary CTA button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // TODO: Navigate to restaurant logging
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: TartColors.white,
                                        side: const BorderSide(
                                          color: TartColors.white,
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                      ),
                                      child: const Text(
                                        'Log Your Find',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Bottom Navigation Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildBottomNavItem(Icons.home, 'Home', true),
                          _buildBottomNavItem(Icons.explore, 'Discover', false),
                          _buildBottomNavItem(Icons.info_outline, 'About', false),
                          _buildBottomNavItem(Icons.people_outline, 'Community', false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// Animated Side Menu Overlay
              AnimatedBuilder(
                animation: _menuAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(-300 * (1 - _menuAnimation.value), 0), // Slide in effect
                    child: Container(
                      width: 300,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: TartColors.white.withValues(alpha: 0.95),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(2, 0),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),

                              // Menu header/logo
                              Text(
                                'tart',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: TartColors.sunriseOrange,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'There\'s a restaurant there?!',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: TartColors.sunriseOrange.withValues(alpha: 0.7),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Menu items
                              _buildMenuItem(Icons.home, 'Home', true),
                              _buildMenuItem(Icons.explore, 'Discover', false),
                              _buildMenuItem(Icons.info_outline, 'About', false),
                              _buildMenuItem(Icons.people_outline, 'Community', false),
                              _buildMenuItem(Icons.add, 'Add Restaurant', false),

                              const Spacer(),

                              // Hint for closing menu
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: TartColors.sunriseOrange.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.touch_app,
                                      size: 16,
                                      color: TartColors.sunriseOrange.withValues(alpha: 0.7),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Tap anywhere to close',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: TartColors.sunriseOrange.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              /// Transparent overlay to detect taps for closing the menu
              if (_isMenuOpen)
                GestureDetector(
                  onTap: _toggleMenu,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable method to build hamburger menu bar (line segment)
  Widget _buildMenuBar() {
    return Container(
      width: 20,
      height: 2.5,
      decoration: BoxDecoration(
        color: TartColors.white,
        borderRadius: BorderRadius.circular(1.25),
      ),
    );
  }

  /// Bottom navigation item builder
  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? TartColors.white : TartColors.white.withValues(alpha: 0.6),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? TartColors.white : TartColors.white.withValues(alpha: 0.6),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  /// Side menu item builder
  Widget _buildMenuItem(IconData icon, String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: GestureDetector(
        onTap: () {
          // TODO: Navigate to respective page
          _toggleMenu(); // Close menu when tapped
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? TartColors.sunriseOrange : TartColors.sunriseOrange.withValues(alpha: 0.7),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: isActive ? TartColors.sunriseOrange : TartColors.sunriseOrange.withValues(alpha: 0.7),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
