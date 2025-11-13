import 'package:flutter/material.dart';
import 'add_product_screen.dart'; // import your AddProductScreen file
import '../services/inventory_service.dart';
import '../models/product_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final InventoryService _inventoryService = InventoryService();
  List<Product> _products = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = await _inventoryService.getAllProducts();
      if (!mounted) return;
      setState(() {
        _products = items;
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

  Future<void> _navigateToAddProduct() async {
    final created = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProductScreen()),
    );

    if (created == true) {
      await _fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddProduct, // ➕ Add Product Button
          )
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search products",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),

          // 📦 Product List
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!))
                    : RefreshIndicator(
                        onRefresh: _fetch,
                        child: ListView.builder(
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            final p = _products[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  p.productName.isNotEmpty
                                      ? p.productName[0].toUpperCase()
                                      : '?',
                                ),
                              ),
                              title: Text(
                                p.productName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("SKU: ${p.sku} | Category: ${p.category}"),
                              trailing: Text(
                                "Stock: ${p.availableQty}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (p.availableQty <= (p.minStock))
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
