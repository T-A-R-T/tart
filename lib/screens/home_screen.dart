import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavBar(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'tart',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: TartColors.white,
                  height: 1.0,
                  letterSpacing: -2,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'There\'s a restaurant there?!',
                style: TextStyle(
                  fontSize: 16,
                  color: TartColors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Discover hidden restaurants\nin your area',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: TartColors.white,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Curated by locals, verified by taste.\nFind your next favorite spot.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: TartColors.white,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 48),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
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
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {},
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
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
