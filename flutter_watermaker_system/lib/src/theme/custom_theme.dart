import 'package:flutter/material.dart';
import 'package:flutter_watermaker_system/flutter_watermaker_system.dart';
import 'package:flutter_watermaker_system/src/theme/custom_colors.dart';

class CustomTheme extends ThemeExtension<CustomTheme> {
  final CustomFontStyle fontStyle;
  final CustomColors colors;

  const CustomTheme({
    this.colors = const CustomColors(),
    this.fontStyle = const CustomFontStyle(),
  });

  @override
  ThemeExtension<CustomTheme> copyWith({
    CustomFontStyle? fontStyle,
    CustomColors? colors,
  }) {
    return CustomTheme(
      colors: colors ?? this.colors,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }

  @override
  ThemeExtension<CustomTheme> lerp(
      covariant ThemeExtension<CustomTheme>? other, double t) {
    return this;
  }

  ThemeData buildTheme() {
    return ThemeData(
      extensions: <ThemeExtension<dynamic>>[this],
      primaryColor: colors.primary,
      cardColor: colors.secondary2,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.primaryDark,
      ),
      textTheme: TextTheme(
        titleMedium: fontStyle.titleMedium,
        bodyMedium: fontStyle.bodyMedium,
      ),
    );
  }

  factory CustomTheme.of(BuildContext context) {
    return Theme.of(context).extension<CustomTheme>() ?? const CustomTheme();
  }
}
