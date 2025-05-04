import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../services/sales_service.dart';

class SalesChart extends StatefulWidget {
  const SalesChart({super.key});

  @override
  State<SalesChart> createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  final SalesService _salesService = SalesService();
  final ProductController _productController = Get.find<ProductController>();
  final CartController _cartController = Get.find<CartController>();
  final RxMap<String, int> salesData = <String, int>{}.obs;
  Worker? _worker;

  @override
  void initState() {
    super.initState();
    _loadSalesData();
    _worker = ever(_cartController.salesUpdated, (_) => _loadSalesData());
  }

  @override
  void dispose() {
    _worker?.dispose();
    super.dispose();
  }

  Future<void> _loadSalesData() async {
    final data = await _salesService.getSalesData();
    salesData.value = data;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = _productController.products.take(4).toList();

      final barGroups =
          products.asMap().entries.map((entry) {
            final index = entry.key;
            final product = entry.value;
            final sales = salesData[product.id.toString()] ?? 0;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: sales.toDouble(),
                  width: 15,
                  gradient: _barsGradient,
                ),
              ],
            );
          }).toList();

      final maxY =
          salesData.isEmpty
              ? 10.0
              : (salesData.values.reduce((a, b) => a > b ? a : b) + 2)
                  .toDouble();

      return Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Product Sales',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    barGroups: barGroups,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        axisNameWidget: const Text('Units Sold'),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameWidget: const Text('Products'),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < products.length) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  products[index].title.split(' ')[0],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine:
                          (value) =>
                              FlLine(color: Colors.grey[300], strokeWidth: 1),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(color: Colors.grey[400]!),
                        bottom: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                    maxY: maxY,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  LinearGradient get _barsGradient => const LinearGradient(
    colors: [Color(0xFFFFF8E1), Color(0xFFD4AF37)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}
