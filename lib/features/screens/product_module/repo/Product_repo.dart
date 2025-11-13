import 'dart:convert';
import 'package:bloc_login/features/screens/product_module/model/products_list_model.dart';
import 'package:http/http.dart' as http;

class ProductService {

  final String _url = "https://shiserp.com/demo/api/productList";


  Future<Map<String, dynamic>> getProducts({int page = 1, int pageSize = 8}) async{
    try {
      final response = await http.post(
        Uri.parse(_url),
        body: {
          "search_text": "",
          "page_number": "$page",
          "page_size": "$pageSize",
          "db_connection": "erp_tata_steel_demo"
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final data = jsonData['data'] ?? {};
        final ProductList = data['ProductList'] ?? [];
        final totalPendingSalary = data['total_pending_salary'] ?? "0";
        return {
          "Products": (ProductList as List)
              .map((e) => ProductListModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          "pendingSalary": double.tryParse(totalPendingSalary.toString()) ?? 0.0,
        };
      } else {
        throw Exception('Failed to load Products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
