import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/inventory/bloc/out_off_product/out_off_stck_event.dart';
import 'package:bloc_login/features/screens/inventory/bloc/out_off_product/out_off_stck_state.dart';
import 'package:bloc_login/features/screens/inventory/model/out_off_product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class OutOfStockBloc extends Bloc<OutOfStockEvents, OutOfStockStates> {
  OutOfStockBloc() : super(InitialOutOfStockState()) {
    on<LoadOutOfStockEvent>((event, emit) async {
      emit(LoadingOutOfStockState());

      try {
        OutOfStockResponse outOfStockResponse = (await fetchOutOfStockList(
          dbConnection: 'erp_tata_steel_demo',
          pageNumber: event.pageNumber ?? '1',
          pageSize: '10',
          userId: '1',
          search_text: event.search_text ?? '',
          branchId: event.branchId ?? '',
          categoryId: event.categoryId ?? '',
          urgencyLevel: event.urgencyLevel ?? '',
        ));
        if (outOfStockResponse.status == 200) {
          emit(LoadedOutOfStockState(outOfStockResponse: outOfStockResponse));
        } else {
          emit(FailureOutOfStockState(error: outOfStockResponse.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorOutOfStockState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorOutOfStockState(error: "HTTP error occurred: ${e.message}"));
        }
      } catch (error) {
        emit(FailureOutOfStockState(error: "An error occurred: $error"));
      }
    });
  }

  Future<OutOfStockResponse> fetchOutOfStockList({
    required String dbConnection,
    required String pageNumber,
    required String pageSize,
    required String userId,
    required String search_text,
    required String branchId,
    required String categoryId,
    required String urgencyLevel,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'page_number': pageNumber,
      'page_size': pageSize,
      'user_id': userId,
      'search_text': search_text,
      'branch_id': branchId,
      'category_id': categoryId,
      'urgency_level': urgencyLevel,
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/outOfStockList");

    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        return OutOfStockResponse.fromJson(json.decode(response.body));
      } else {
        throw HttpException('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Error: $e');
    }
  }
}
