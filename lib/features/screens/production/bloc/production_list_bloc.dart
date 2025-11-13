import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/production/bloc/production_list_event.dart';
import 'package:bloc_login/features/screens/production/bloc/production_list_state.dart';
import 'package:bloc_login/features/screens/production/model/production_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ProductionListBloc extends Bloc<ProductionListEvents, ProductionListStates> {
  ProductionListBloc() : super(InitialProductionListState()) {
    on<FetchProductionListEvent>((event, emit) async {
      emit(LoadingProductionListState());

      try {
        ProductionResponse model = await fetchProductionListList(
          dbConnection: 'erp_tata_steel_demo',
          ProductionCategoryId: event.ProductionCategoryId ?? '',
          pageNumber: event.pageNumber ?? '1',
          pageSize: '10',
          userId: '1',
          status: event.status ?? '',
        );
        if (model.status == 200) {
          emit(LoadedProductionListState(model: model));
        } else {
          emit(FailureProductionListState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorProductionListState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorProductionListState(error: "HTTP error occurred: ${e.message}"));
        }
      } catch (error) {
        emit(FailureProductionListState(error: "An error occurred: $error"));
      }
    });
  }

  Future<ProductionResponse> fetchProductionListList({
    required String dbConnection,
    required String ProductionCategoryId,
    required String pageNumber,
    required String pageSize,
    required String userId,
    required String status,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'Production_category_id': ProductionCategoryId,
      'page_number': pageNumber,
      'page_size': pageSize,
      'user_id': userId,
      'status': status,
    };


    final Uri url = Uri.parse("https://shiserp.com/demo/api/getProductionList");

    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        return ProductionResponse.fromJson(json.decode(response.body));
      } else {
        throw HttpException('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Error: $e');
    }
  }
}
