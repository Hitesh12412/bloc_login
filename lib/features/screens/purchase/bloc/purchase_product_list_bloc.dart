import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_event.dart';
import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_state.dart';
import 'package:bloc_login/features/screens/purchase/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PurchaseListBloc extends Bloc<PurchaseListEvents, PurchaseListStates> {
  PurchaseListBloc() : super(InitialPurchaseListState()) {
    on<FetchPurchaseListEvent>((event, emit) async {
      emit(LoadingPurchaseListState());

      try {
        PurchaseResponse model = await fetchPurchaseListList(
          dbConnection: 'erp_tata_steel_demo',
          PurchaseCategoryId: event.PurchaseCategoryId ?? '',
          pageNumber: event.pageNumber ?? '1',
          pageSize: '10',
          userId: '1',
          status: event.status ?? '',
        );
        if (model.status == 200) {
          emit(LoadedPurchaseListState(model: model));
        } else {
          emit(FailurePurchaseListState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorPurchaseListState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorPurchaseListState(error: "HTTP error occurred: ${e.message}"));
        }
      } catch (error) {
        emit(FailurePurchaseListState(error: "An error occurred: $error"));
      }
    });
  }

  Future<PurchaseResponse> fetchPurchaseListList({
    required String dbConnection,
    required String PurchaseCategoryId,
    required String pageNumber,
    required String pageSize,
    required String userId,
    required String status,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'Purchase_category_id': PurchaseCategoryId,
      'page_number': pageNumber,
      'page_size': pageSize,
      'user_id': userId,
      'status': status,
    };

    print('API Request Data: $data');

    final Uri url = Uri.parse("https://shiserp.com/demo/api/getPurchaseProductList");

    try {
      final response = await http.post(url, body: data);
      print('API Response Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return PurchaseResponse.fromJson(json.decode(response.body));
      } else {
        throw HttpException('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
      throw HttpException('Error: $e');
    }
  }
}
