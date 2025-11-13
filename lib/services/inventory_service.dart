import '../models/product_model.dart';
import 'api_client.dart';

class InventoryService {
  final ApiClient _api = ApiClient();

  Future<List<Product>> getAllProducts() async {
    final res = await _api.get('/inventory/getall');
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Product.fromJson).toList();
  }

  Future<Product> createProduct(Product product) async {
    final res = await _api.post('/inventory/create', product.toCreateJson());
    return Product.fromJson(Map<String, dynamic>.from(res));
  }

  Future<Map<String, dynamic>> getStockSummary() async {
    final res = await _api.get('/inventory/stock-summary');
    return Map<String, dynamic>.from(res as Map);
  }

  Future<Map<String, dynamic>> getLowStockCount() async {
    final res = await _api.get('/inventory/alerts/lowstockcount');
    return Map<String, dynamic>.from(res as Map);
  }

  Future<List<Product>> getLowStockProducts() async {
    final res = await _api.get('/inventory/alerts/lowstock');
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Product.fromJson).toList();
  }
}



