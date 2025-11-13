import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'dashboard_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  final AuthService _auth = AuthService();

  // ✅ Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // ✅ Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // ✅ Handle login
  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await _auth.signIn(_emailController.text.trim(), _passwordController.text);
        if (!mounted) return;
        setState(() => _isLoading = false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login successful!"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields correctly."),
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Top green header
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
                            "Welcome Back 👋",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Login to continue",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 🔹 Email field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 🔹 Password field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),

                // 🔹 Forgot Password
                Padding(
                  padding: const EdgeInsets.only(right: 24, top: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // 🔹 Sign Up link
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Don’t have an account? ",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004D40),
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