
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';

class NavBar extends StatefulWidget {
  final Widget body;

  const NavBar({super.key, required this.body});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: TartColors.sunriseGradient,
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'tart',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: TartColors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: _toggleMenu,
                            child: Container(
                              width: 48,
                              height: 48,
                              alignment: Alignment.center,
                              child: AnimatedBuilder(
                                animation: _menuAnimation,
                                builder: (context, child) {
                                  return SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 7,
                                          left: 3,
                                          child: Transform.rotate(
                                            angle: _menuAnimation.value * 0.785398,
                                            child: _buildMenuBar(),
                                          ),
                                        ),
                                        Positioned(
                                          top: 13,
                                          left: 3,
                                          child: Transform.scale(
                                            scale: 1 - _menuAnimation.value,
                                            child: _buildMenuBar(),
                                          ),
                                        ),
                                        Positioned(
                                          top: 19,
                                          left: 3,
                                          child: Transform.rotate(
                                            angle: -_menuAnimation.value * 0.785398,
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
                    Expanded(
                      child: widget.body,
                    ),
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
              AnimatedBuilder(
                animation: _menuAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(-300 * (1 - _menuAnimation.value), 0),
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
                              _buildMenuItem(Icons.home, 'Home', true),
                              _buildMenuItem(Icons.explore, 'Discover', false),
                              _buildMenuItem(Icons.info_outline, 'About', false),
                              _buildMenuItem(Icons.people_outline, 'Community', false),
                              _buildMenuItem(Icons.add, 'Add Restaurant', false),
                              const Spacer(),
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

  Widget _buildMenuItem(IconData icon, String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: GestureDetector(
        onTap: () {
          _toggleMenu();
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
