import 'package:flutter/material.dart';
import 'login_screen.dart'; // ✅ Import LoginScreen

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // ✅ Form key for validation

  // ✅ Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    const pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // ✅ Handle reset link logic
  void _handleReset() {
    if (_formKey.currentState!.validate()) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset link sent to your email!"),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to login screen after delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      });
    } else {
      // If invalid, show red snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email before proceeding"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // ✅ Attach form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Top green curved header
                Container(
                  width: double.infinity,
                  height: 260,
                  decoration: const BoxDecoration(
                    color: Color(0xFF004D40),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Enter your registered email to reset your password.",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 🔹 Email Input Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      hintText: "Enter your email ID",
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Reset Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D40),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _handleReset, // ✅ Validate and navigate
                      child: const Text(
                        "Send reset Link",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Back to Login
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Remember your Password? ",
                        style: TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
