import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    // Skip → directly go to Login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Track Every Income\nEffortlessly",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Log your earnings, monitor growth, and take\ncontrol of your finances.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 30),
              // 🖼 Replace with your image asset
              Image.asset(
                "assets/images/onboarding.png",
                fit: BoxFit.contain,
                height: 300,
              ),
              const Spacer(),
              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D40), // dark green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Log In link
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.black54),
                    children: [
                      TextSpan(
                        text: "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}