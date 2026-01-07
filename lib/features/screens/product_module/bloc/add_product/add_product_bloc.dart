import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'add_product_event.dart';
import 'add_product_state.dart';

class ProductCreateBloc extends Bloc<ProductCreateEvent, ProductCreateState> {
  ProductCreateBloc() : super(const ProductCreateInitial()) {
    on<ProductCreateRequested>(_onCreateProduct);
  }

  Future<void> _onCreateProduct(
      ProductCreateRequested event,
      Emitter<ProductCreateState> emit,
      ) async {
    emit(const ProductCreateLoading());

    try {
      final response = await http
          .post(
        Uri.parse('https://shiserp.com/demo/api/addProduct'),
        headers: const {
          'Accept': 'application/json',
        },
        body: {
          'user_id': event.userId,
          'db_connection': 'erp_tata_steel_demo',
          'category_id': event.categoryId,
          'sub_category_id': event.subCategoryId,
          'brand_id': event.brandId,
          'unit_id': event.unitId,
          'product_type_id': event.productTypeId,
          'name': event.name,
          'product_price': event.productPrice,
          'qty': event.qty,
          'tax1': event.tax1,
          'tax1_rate': event.tax1Rate,
          'tax2': event.tax2,
          'tax2_rate': event.tax2Rate,
          'tax3': event.tax3,
          'tax3_rate': event.tax3Rate,
          'product_data': event.productData,
        },
      )
          .timeout(const Duration(seconds: 20));

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded is Map &&
          decoded['status'] == 200) {
        emit(ProductCreateSuccess(
            decoded['message']?.toString() ??
                'Product created successfully'));
      } else {
        emit(ProductCreateFailure(
            decoded is Map
                ? decoded['message']?.toString() ??
                'Failed to create product'
                : 'Unexpected server response'));
      }
    } on http.ClientException {
      emit(const ProductCreateFailure('Network error'));
    } on FormatException {
      emit(const ProductCreateFailure('Invalid server response'));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('CREATE PRODUCT ERROR ❌ $e');
      }
      emit(const ProductCreateFailure('Something went wrong'));
    }
  }
}
