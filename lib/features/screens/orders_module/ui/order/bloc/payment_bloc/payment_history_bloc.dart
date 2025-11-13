import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/payment_bloc/payment_history_event.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/payment_bloc/payment_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class PaymentHistoryBloc extends Bloc<PaymentHistoryEvents, PaymentHistoryStates> {
  PaymentHistoryBloc() : super(InitialPaymentHistoryState()) {
    on<FetchPaymentHistoryEvent>((event, emit) async {
      emit(LoadingPaymentHistoryState());
      try {
        PaymentHistoryListModel model = await fetchPaymentHistoryList(
          userID: event.userId,
        );
        if (model.status == 200) {
          emit(LoadedPaymentHistoryState(model: model));
        }
        else {
          emit(FailurePaymentHistoryState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorPaymentHistoryState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorPaymentHistoryState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailurePaymentHistoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<PaymentHistoryListModel> fetchPaymentHistoryList({
    required userID,
  }) async {
    final data = {
      'user_id': userID,
      'db_connection': "erp_tata_steel_demo",
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/PaymentHistoryList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return PaymentHistoryListModel.fromJsonMap(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
