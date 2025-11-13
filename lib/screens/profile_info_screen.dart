import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  String name = "";
  String email = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "Ethan Carter";
      email = prefs.getString('email') ?? "ethan.carter@gmail.com";
      phone = prefs.getString('phone') ?? "+91 9876543210";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Info"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: _loadProfile,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/profile.png"),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Full Name", style: TextStyle(color: Colors.grey)),
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 30),

            const Text("Email", style: TextStyle(color: Colors.grey)),
            Text(email, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 30),

            const Text("Phone", style: TextStyle(color: Colors.grey)),
            Text(phone, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
