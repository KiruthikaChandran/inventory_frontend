import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Need Assistance?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("You can contact us anytime at:", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.email, color: Colors.black),
              title: const Text("support@inventoryapp.com"),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.black),
              title: const Text("+91 9524577795"),
            ),
          ],
        ),
      ),
    );
  }
}
