import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'products_list_event.dart';
import 'products_list_state.dart';
import 'package:bloc_login/features/screens/product_module/model/products_list_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(
      (event, emit) async {
        emit(ProductLoading());
        try {
          final response = await fetchProductList(
            dbConnection: event.dbConnection,
            searchText: event.searchText,
            pageNumber: event.pageNumber,
            pageSize: event.pageSize,
          );

          if (response['status'] == 200 && response['data'] is List) {
            final products = (response['data'] as List)
                .map((e) => ProductListModel.fromJson(e))
                .toList();

            final int totalPages = response['totalPages'] ?? 1;
            final bool hasNextPage = response['hasNextPage'] ?? false;
            final int totalCount = response['totalCount'] ?? products.length;

            emit(
              ProductLoaded(
                products: products,
                currentPage: event.pageNumber,
                totalPages: totalPages,
                hasNextPage: hasNextPage,
                totalCount: totalCount,
              ),
            );
          } else {
            emit(ProductError(
                message: response['message'] ?? 'Failed to fetch products'));
          }
        } on HttpException catch (e) {
          emit(
            ProductError(message: "HTTP error: ${e.message}"),
          );
        } catch (error) {
          emit(
            ProductError(message: "An error occurred: $error"),
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchProductList({
    required String dbConnection,
    required String searchText,
    required int pageNumber,
    required int pageSize,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'search_text': searchText,
      'page_number': pageNumber.toString(),
      'page_size': pageSize.toString(),
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/productList");
    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
