import 'package:flutter/material.dart';
import 'alerts_screen.dart';
import 'product_screen.dart';
import 'add_product_screen.dart';
import 'profile_screen.dart'; // ✅ Import Profile Screen
import '../services/inventory_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final InventoryService _inventoryService = InventoryService();
  bool _loading = true;
  String? _error;
  int _totalProducts = 0;
  int _inStock = 0;
  int _lowStock = 0;
  int _outOfStock = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final summary = await _inventoryService.getStockSummary();
      if (!mounted) return;
      setState(() {
        _totalProducts = (summary['totalProducts'] ?? 0) as int;
        _inStock = (summary['inStockCount'] ?? 0) as int;
        _lowStock = (summary['lowStockCount'] ?? 0) as int;
        _outOfStock = (summary['outOfStockCount'] ?? 0) as int;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Inventory",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading dashboard',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _load,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF004D40),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Alerts Section
            const Text(
              "Alerts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Low Stock",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("$_lowStock items", style: const TextStyle(color: Colors.blue)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AlertsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: const Text("View"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("Total Products", "$_totalProducts"),
                _buildStatCard("In Stock", "$_inStock"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("Low Stock", "$_lowStock"),
                _buildStatCard("Out of Stock", "$_outOfStock"),
              ],
            ),

            const SizedBox(height: 24),

            // 🔹 Recent Activity
            const Text(
              "Recent Activity",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildActivityTile(Icons.arrow_upward, "Restocked",
                "Apple airtags", "100 units", Colors.green),
            _buildActivityTile(Icons.arrow_downward, "Adjusted",
                "Logitech MX keys", "50 units", Colors.orange),
          ],
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 1) {
            // ✅ Navigate to Products Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductsScreen()),
            );
          } else if (index == 2) {
            // ✅ Navigate to Add Product Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddProductScreen()),
            );
          } else if (index == 3) {
            // ✅ Navigate to Profile Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // Widget for Stats
  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Recent Activity
  Widget _buildActivityTile(
      IconData icon, String action, String product, String qty, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "$action: ",
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            TextSpan(text: product),
          ],
        ),
      ),
      subtitle: Text(qty),
    );
  }
}
