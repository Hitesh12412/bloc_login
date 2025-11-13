import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/order_list/order_list_event.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/order_list/order_list_state.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/model/order_list/oder_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  OrderBloc() : super(InitialOrderState()) {
    on<FetchOrderEvent>((event, emit) async {
      emit(LoadingOrderState());
      try {
        final model = await fetchOrderList(
          userID: event.userId,
          searchText: event.searchText,
        );
        if (model.status == 200) {
          emit(LoadedOrderState(model: model));
        } else {
          emit(FailureOrderState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorOrderState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorOrderState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureOrderState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<OrderListModel> fetchOrderList({
    required String userID,
    String? searchText,
  }) async {
    final data = <String, String>{
      'user_id': userID,
      'db_connection': "erp_tata_steel_demo",
        'search_text': searchText ?? '',
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/orderList");
    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      return OrderListModel.fromJsonMap(json.decode(response.body));
    } else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
