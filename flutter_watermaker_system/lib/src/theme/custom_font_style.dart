import 'package:flutter/material.dart';

class CustomFontStyle {
  const CustomFontStyle();

  final TextStyle titleMedium = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    color: Colors.greenAccent,
  );

  final TextStyle bodyMedium = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: Colors.black87,
  );
}

extension TextStyleExt on TextStyle {
  /// fontWeight: FontWeight.bold
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  /// fontWeight: FontWeight.normal
  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);

  /// set fontSize to [fontSize]
  TextStyle fs(double fontSize) => copyWith(fontSize: fontSize);

  /// set Color to [color]
  TextStyle cl(Color color) => copyWith(color: color);
}
