import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
