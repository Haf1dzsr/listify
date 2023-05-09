import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:listify/views/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // delay 3 sec before off to HomeScreen
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (Route<dynamic> route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_logo.png',
              width: 300,
              height: 250,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Listify',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Your Friendly Shopping List App',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
