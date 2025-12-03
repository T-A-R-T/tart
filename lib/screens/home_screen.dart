import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import '../widgets/app_navbar.dart';

/// HomeScreen widget, main landing page of the app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          child: SafeArea(
            child: AppNavbar(
              child: Column(
                children: [

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
          ),
        ),
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
}
