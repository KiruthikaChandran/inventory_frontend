class Product {
  final String id;
  final String productName;
  final String sku;
  final String description;
  final String category;
  final int availableQty;
  final String unit;
  final double cost;
  final double mrp;
  final String notes;
  final String supplier;
  final String location;
  final int minStock;

  Product({
    required this.id,
    required this.productName,
    required this.sku,
    this.description = '',
    this.category = '',
    required this.availableQty,
    this.unit = 'pcs',
    required this.cost,
    required this.mrp,
    this.notes = '',
    this.supplier = '',
    this.location = '',
    this.minStock = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id']?.toString() ?? '',
      productName: json['productName'] ?? '',
      sku: json['sku'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      availableQty: (json['availableQty'] ?? 0) is int
          ? (json['availableQty'] ?? 0)
          : int.tryParse('${json['availableQty']}') ?? 0,
      unit: json['unit'] ?? 'pcs',
      cost: (json['cost'] ?? 0).toDouble(),
      mrp: (json['mrp'] ?? 0).toDouble(),
      notes: json['notes'] ?? '',
      supplier: json['supplier'] ?? '',
      location: json['location'] ?? '',
      minStock: (json['minStock'] ?? 0) is int
          ? (json['minStock'] ?? 0)
          : int.tryParse('${json['minStock']}') ?? 0,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'productName': productName,
      'sku': sku,
      'description': description,
      'category': category,
      'availableQty': availableQty,
      'unit': unit,
      'cost': cost,
      'mrp': mrp,
      'notes': notes,
      'supplier': supplier,
      'location': location,
      'minStock': minStock,
    };
  }
}



