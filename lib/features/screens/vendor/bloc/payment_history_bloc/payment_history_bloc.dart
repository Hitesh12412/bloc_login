import 'dart:convert';
import 'package:bloc_login/features/screens/vendor/model/payment_history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
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
          'vendor_level_id': '0',
          'search_text': '',
          'product_id': '',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final model = VendorPaymentResponse.fromJson(decoded);
        emit(PaymentHistoryLoaded(model.data));
      } else {
        emit(PaymentHistoryError(
          decoded['message']?.toString() ?? 'Server error',
        ));
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(PaymentHistoryError(e.toString()));
    }
  }
}
