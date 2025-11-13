import 'package:flutter/material.dart';
import '../services/inventory_service.dart';
import '../models/product_model.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final InventoryService _inventoryService = InventoryService();
  bool _loading = true;
  String? _error;
  int _lowStockCount = 0;
  List<Product> _lowStockProducts = [];

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
      final products = await _inventoryService.getLowStockProducts();
      if (!mounted) return;
      setState(() {
        _lowStockProducts = products;
        _lowStockCount = products.length;
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
        title: const Text(
          "Alerts",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),

        // 🔹 3-dot popup menu
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "mark_read") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All alerts marked as read")),
                );
              } else if (value == "delete") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All alerts deleted")),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "mark_read",
                child: Text("Mark all as read"),
              ),
              const PopupMenuItem(
                value: "delete",
                child: Text("Delete"),
              ),
            ],
          ),
        ],
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildAlertTile(
                        "Low Stock",
                        _lowStockCount == 0
                            ? "All items stocked"
                            : "$_lowStockCount item${_lowStockCount == 1 ? '' : 's'} need attention",
                        Colors.orange,
                      ),
                      if (_lowStockProducts.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Text(
                          "Items needing restock",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                      ],
                      ..._lowStockProducts
                          .map((product) => _buildLowStockTile(product))
                          ,
                      if (_lowStockProducts.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              "Great! No low stock items right now.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }

  // 🔹 Helper widget for alerts
  Widget _buildAlertTile(String title, String subtitle, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(Icons.notifications, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildLowStockTile(Product product) {
    final bool isCritical = product.availableQty <= product.minStock;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCritical ? Colors.red.shade100 : Colors.orange.shade100,
          child: Text(
            product.productName.isNotEmpty
                ? product.productName[0].toUpperCase()
                : '?',
            style: TextStyle(
              color: isCritical ? Colors.red.shade800 : Colors.orange.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          product.productName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Stock: ${product.availableQty} ${product.unit} • Min: ${product.minStock}",
        ),
        trailing: Icon(
          Icons.warning_amber_outlined,
          color: isCritical ? Colors.red.shade700 : Colors.orange.shade700,
        ),
      ),
    );
  }
}