import 'package:app_design/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_watermaker_system/flutter_watermaker_system.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();
    return MaterialApp(
      title: 'Flutter App Design',
      debugShowCheckedModeBanner: false,
      theme: theme.buildTheme(),
      home: const HomePage(),
    );
  }
}
