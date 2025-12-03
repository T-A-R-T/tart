import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// App Navigation Bar with hamburger menu functionality
/// Extracted from HomeScreen to allow reusability
class AppNavbar extends StatefulWidget {
  final Widget child; // Child widget to display below navbar

  const AppNavbar({super.key, required this.child});

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

/// States class for AppNavbar
/// Handles menu animation and side menu overlay
class _AppNavbarState extends State<AppNavbar> with TickerProviderStateMixin {
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
    return Stack(
      children: [
        // Main content with navbar
        Column(
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
            // Child content
            Expanded(child: widget.child),
          ],
        ),

        /// Animated Side Menu Overlay - Only show when menu is open
        if (_isMenuOpen)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: AnimatedBuilder(
              animation: _menuAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(-300 * (1 - _menuAnimation.value), 0), // Slide in effect
                  child: Container(
                    width: 300,
                    height: MediaQuery.of(context).size.height,
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
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60), // Account for status bar

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
                            margin: const EdgeInsets.only(bottom: 40), // Account for bottom safe area
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
                );
              },
            ),
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

  /// Side menu item builder
  Widget _buildMenuItem(IconData icon, String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: GestureDetector(
        onTap: () {
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