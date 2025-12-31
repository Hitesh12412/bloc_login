import 'dart:convert';
import 'package:bloc_login/features/screens/vendor/model/payment_history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'payment_history_event.dart';
import 'payment_history_state.dart';

class PaymentHistoryBloc
    extends Bloc<PaymentHistoryEvent, PaymentHistoryState> {
  PaymentHistoryBloc() : super(PaymentHistoryInitial()) {
    on<FetchPaymentHistory>(_fetch);
  }

  Future<void> _fetch(
      FetchPaymentHistory event,
      Emitter<PaymentHistoryState> emit,
      ) async {
    emit(PaymentHistoryLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/addPaymentVendorList'),
        body: {
          'db_connection': 'erp_tata_steel_demo',
          'user_id': '1',
          'page_number': '1',
          'page_size': '30',
          'search_text': '',
        },
      );

      if (response.statusCode == 200) {
        final model =
        VendorPaymentResponse.fromJson(jsonDecode(response.body));

        if (model.status == 200 && model.data.isNotEmpty) {
          emit(PaymentHistoryLoaded(model.data));
        } else {
          emit(PaymentHistoryError(model.message));
        }
      } else {
        emit(PaymentHistoryError(
            'Server error ${response.statusCode}'));
      }
    } catch (_) {
      emit(PaymentHistoryError('Something went wrong'));
    }
  }
}
