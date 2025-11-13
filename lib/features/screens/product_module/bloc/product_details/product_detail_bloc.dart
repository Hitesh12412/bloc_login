import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/product_module/bloc/product_details/product_detail_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/product_details/product_detail_state.dart';
import 'package:bloc_login/features/screens/product_module/model/product_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class ProductDetailBloc extends Bloc<ProductDetailEvents, ProductDetailStates> {
  ProductDetailBloc() : super(InitialProductDetailState()) {
    on<FetchProductDetailEvent>((event, emit) async {
      emit(LoadingProductDetailState());
      try {
        ProductDetailModel model = await fetchProductDetailList(
          productId: event.productID,
        );

        if (model.status == 200) {
          emit(LoadedProductDetailState(model: model));
        }
        else {
          emit(FailureProductDetailState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorProductDetailState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorProductDetailState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureProductDetailState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<ProductDetailModel> fetchProductDetailList({
    required String productId,
  }) async {
    final data = {
      'product_id': productId,
      'db_connection': "erp_tata_steel_demo",
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/productDetails");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return ProductDetailModel.fromJson(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}


