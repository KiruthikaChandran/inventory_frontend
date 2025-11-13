import 'dart:io';
import 'package:flutter/material.dart';

class DraftScreen extends StatelessWidget {
  final List<Map<String, dynamic>> drafts;

  const DraftScreen({super.key, required this.drafts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Draft")),
      body: drafts.isEmpty
          ? const Center(
              child: Text(
                "No Drafts Available",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: drafts.length,
              itemBuilder: (context, index) {
                final draft = drafts[index];
                return ListTile(
                  leading: draft["image"] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(draft["image"]),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image, color: Colors.white),
                        ),
                  title: Text(
                    draft["name"] ?? "Unnamed Product",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Draft   Stock: ${draft["stock"] ?? 0}\n"
                    "SKU: ${draft["sku"] ?? "N/A"} | Category: ${draft["category"] ?? "N/A"}",
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
    );
  }
}
