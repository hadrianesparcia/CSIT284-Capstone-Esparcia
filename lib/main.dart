import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';

void main() => runApp(const CanteenApp());

class CanteenApp extends StatelessWidget {
  const CanteenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen Pre-Order',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
}