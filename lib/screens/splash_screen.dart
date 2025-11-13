import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF76B852), Color(0xFF8DC26F)],
          ).createShader(bounds),
          child: const Text(
            "Inventory\nManagement",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white, // ShaderMask replaces this with gradient
            ),
          ),
        ),
      ),
    );
  }
}