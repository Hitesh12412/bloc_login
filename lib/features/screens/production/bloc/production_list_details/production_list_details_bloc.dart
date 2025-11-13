import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bloc_login/features/screens/production/bloc/production_list_details/production_list_details_event.dart';
import 'package:bloc_login/features/screens/production/bloc/production_list_details/production_list_details_state.dart';
import 'package:bloc_login/features/screens/production/model/details_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductionDetailBloc
    extends Bloc<ProductionDetailEvents, ProductionDetailStates> {
  ProductionDetailBloc() : super(InitialProductionDetailState()) {
    on<FetchProductionDetailEvent>(_onFetchDetail);
  }

  Future<void> _onFetchDetail(FetchProductionDetailEvent event,
      Emitter<ProductionDetailStates> emit,) async {
    emit(LoadingProductionDetailState());

    try {
      final model = await _fetchProductionDetail(orderId: event.orderId);
      if (model.status == 200) {
        emit(LoadedProductionDetailState(model: model));
      } else {
        emit(FailureProductionDetailState(error: model.message));
      }
    } on SocketException {
      emit(ServerErrorProductionDetailState(error: 'No Internet connection'));
    } on HttpException catch (e) {
      emit(ServerErrorProductionDetailState(error: e.message));
    } on FormatException {
      emit(FailureProductionDetailState(error: 'Bad response format'));
    } catch (e, stack) {
      debugPrint('ProductionDetailBloc error → $e');
      debugPrint(stack.toString());
      emit(FailureProductionDetailState(error: e.toString()));
    }
  }

  Future<ProductionDetailModel> _fetchProductionDetail({
    required int orderId,
  }) async {
    final data = {
      'order_id': orderId,
      'db_connection': 'erp_tata_steel_demo',
      'user_id': 1,
    };

    final response = await http.post(
      Uri.parse('https://shiserp.com/demo/api/productionDetailList'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw HttpException('Error: ${response.statusCode}');
    }

    return ProductionDetailModel.fromJson(json.decode(response.body));
  }

}

