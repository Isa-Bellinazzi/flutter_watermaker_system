import 'package:flutter/material.dart';

class CustomColors {
  final Color primary;
  final Color primaryDark;
  final Color secondary1;
  final Color secondary2;
  final Color secondary3;

  const CustomColors({
    this.primary = const Color.fromARGB(255, 231, 236, 231),
    this.primaryDark = const Color.fromARGB(255, 71, 168, 237),
    this.secondary1 = const Color.fromARGB(255, 16, 20, 18),
    this.secondary2 = const Color.fromARGB(255, 226, 135, 255),
    this.secondary3 = const Color.fromARGB(255, 255, 112, 84),
  });
}
