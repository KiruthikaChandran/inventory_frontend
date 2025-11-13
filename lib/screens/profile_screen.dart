import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/profile_option_tile.dart';
import 'profile_info_screen.dart';
import 'edit_profile_screen.dart';
import 'faq_screen.dart';
import 'help_support_screen.dart';
import 'delete_account_screen.dart';
import 'logout_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Ethan Carter";
  String email = "ethan.carter@gmail.com";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? name;
      email = prefs.getString('email') ?? email;
    });
  }

  // ✅ Refresh after edit
  Future<void> _navigateToEditProfile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
    );

    if (result == true) {
      _loadProfile(); // refresh data after editing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage("assets/profile.png"),
          ),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(email, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ProfileOptionTile(
                  icon: Icons.person,
                  title: "Profile Info",
                  subtitle: "User Profile",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileInfoScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.edit,
                  title: "Edit Profile",
                  subtitle: "Update your details",
                  onTap: () => _navigateToEditProfile(context),
                ),
                ProfileOptionTile(
                  icon: Icons.question_answer,
                  title: "FAQs",
                  subtitle: "Frequently Asked Questions",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FAQScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.support_agent,
                  title: "Help & Support",
                  subtitle: "Get assistance",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.delete_forever,
                  title: "Delete Account",
                  subtitle: "Erase your data",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeleteAccountScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.logout,
                  title: "Logout",
                  subtitle: "Sign out of your account",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LogoutScreen())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
