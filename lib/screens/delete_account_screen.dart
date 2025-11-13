import 'package:flutter/material.dart';
import 'login_screen.dart'; // ✅ Import Login screen

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Delete Account?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Deleting your account is permanent.\nAll your data will be erased and cannot be recovered.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // ✅ Navigate back to LoginScreen after deleting
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false, // Removes all previous routes
                        );

                        // Optional: show confirmation message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Account deleted successfully"),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      },
                      child: const Text(
                        "Delete Account",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
