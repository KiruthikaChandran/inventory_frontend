import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {"q": "How do I edit my profile?", "a": "Go to Profile > Edit Profile."},
      {"q": "How do I delete my account?", "a": "Go to Profile > Delete Account."},
      {"q": "How do I reset my password?", "a": "Use the 'Change password' option in Edit Profile."},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: faqs.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faqs[index]["q"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(faqs[index]["a"]!, style: const TextStyle(color: Colors.grey)),
              )
            ],
          );
        },
      ),
    );
  }
}
