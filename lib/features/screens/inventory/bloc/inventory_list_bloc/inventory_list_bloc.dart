import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/inventory/bloc/inventory_list_bloc/inventory_list_event.dart';
import 'package:bloc_login/features/screens/inventory/bloc/inventory_list_bloc/inventory_list_state.dart';
import 'package:bloc_login/features/screens/inventory/model/inevntory_product_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class InventoryListBloc extends Bloc<InventoryListEvents, InventoryListStates> {
  InventoryListBloc() : super(InitialInventoryListState()) {
    on<LoadInventoryListEvent>((event, emit) async {
      emit(LoadingInventoryListState());

      try {
        InventoryResponse inventoryResponse = (await fetchInventoryProductList(
          dbConnection: 'erp_tata_steel_demo',
          pageNumber: event.pageNumber ?? '1',
          pageSize: '10',
          userId: '1',
          status: event.status ?? '',
          search_text: event.search_text ?? '',
        ));
        if (inventoryResponse.status == 200) {
          emit(LoadedInventoryListState(inventoryResponse: inventoryResponse));
        } else {
          emit(FailureInventoryListState(error: inventoryResponse.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorInventoryListState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorInventoryListState(error: "HTTP error occurred: ${e.message}"));
        }
      } catch (error) {
        emit(FailureInventoryListState(error: "An error occurred: $error"));
      }
    });
  }

  Future<InventoryResponse> fetchInventoryProductList({
    required String dbConnection,
    required String pageNumber,
    required String pageSize,
    required String userId,
    required String status,
    required String search_text,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'page_number': pageNumber,
      'page_size': pageSize,
      'user_id': userId,
      'status': status,
      'search_text': search_text,
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/getInventoryProductList");

    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        return InventoryResponse.fromJson(json.decode(response.body));
      } else {
        throw HttpException('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Error: $e');
    }
  }
}
