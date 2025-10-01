import 'package:flutter/material.dart';

class TartColors {
  static const Color sunriseOrange = Color(0xFFFF6B35);
  static const Color sunsetOrange = Color(0xFFFF8A50);
  static const Color sunsetPink = Color(0xFFFF9B9B);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient sunriseGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      sunriseOrange,
      sunsetOrange,
      sunsetPink,
    ],
  );
}