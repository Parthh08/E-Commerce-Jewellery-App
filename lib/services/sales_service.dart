import '../models/product_model.dart';

class SalesService {
  static final SalesService _instance = SalesService._internal();
  factory SalesService() => _instance;
  SalesService._internal();

  final Map<String, int> _salesData = {};

  Future<void> incrementSales(Product product, int quantity) async {
    final productId = product.id.toString();
    _salesData[productId] = (_salesData[productId] ?? 0) + quantity;

    await Future.delayed(const Duration(milliseconds: 300));
  }

  Map<String, int> get salesData => Map.unmodifiable(_salesData);

  Future<Map<String, int>> getSalesData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return salesData;
  }
}
