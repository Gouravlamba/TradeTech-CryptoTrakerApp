import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color.fromARGB(255, 0, 17, 32);
  static const secondry = Color(0xFF1E1E1E);
  static const surface = Colors.white;
  static const onSurface = Colors.black87;
  static const success = Color(0xFF43A047);
  static const danger = Color(0xFFE53935);

  static final LinearGradient banner = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFCB6CE6),
      Color(0xFFFFBD59),
    ],
  );
}
