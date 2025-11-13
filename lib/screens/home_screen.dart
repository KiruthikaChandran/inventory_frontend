// 📂 lib/screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Inventory",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Alerts
            const Text(
              "Alerts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Low Stock",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "10 items",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("View"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Stats Cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard("Total Products", "120"),
                _buildStatCard("In Stock", "100"),
                _buildStatCard("Low Stock", "10"),
                _buildStatCard("Out of Stock", "10"),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Recent Activity
            const Text(
              "Recent Activity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildActivityItem(Icons.arrow_upward, "Restocked", "Apple airtags", "100 units", Colors.green),
            const SizedBox(height: 10),
            _buildActivityItem(Icons.arrow_downward, "Adjusted", "Logitech MX keys", "50 units", Colors.orange),
          ],
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green.shade900,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // 🔹 Stats card widget
  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // 🔹 Recent activity item
  Widget _buildActivityItem(IconData icon, String action, String item, String qty, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: "$action: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                TextSpan(text: "$item\n"),
                TextSpan(
                  text: qty,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}