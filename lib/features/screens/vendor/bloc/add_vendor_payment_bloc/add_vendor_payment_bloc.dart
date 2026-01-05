import 'dart:convert';
import 'package:bloc_login/features/screens/vendor/bloc/add_vendor_payment_bloc/add_vendor_payment_event.dart';
import 'package:bloc_login/features/screens/vendor/bloc/add_vendor_payment_bloc/add_vendor_payment_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AddPaymentBloc extends Bloc<AddPaymentEvent, AddPaymentState> {
  AddPaymentBloc() : super(const AddPaymentInitial()) {
    on<AddPaymentRequested>(_onCreateVendor);
  }

  Future<void> _onCreateVendor(
      AddPaymentRequested event,
      Emitter<AddPaymentState> emit,
      ) async {
    emit(const AddPaymentLoading());

    final body = {
      'db_connection': 'erp_tata_steel_demo',
      'user_id': event.userId.toString(),
      'vendor_id': event.vendorId.toString(),
      'date': event.date,
      'collected_payment': event.collectedPayment.toString(),
      'payment_method': event.paymentMethod,
      'remarks': event.remarks,
    };

    if (kDebugMode) {
      debugPrint('ADD PAYMENT BODY 👉 $body');
    }

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/vendorAddPayment'),
        headers: const {'Accept': 'application/json'},
        body: body,
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded is Map &&
          decoded['status'] == 200) {
        emit(AddPaymentSuccess(
          decoded['message']?.toString() ?? 'Payment added successfully',
        ));
      } else {
        emit(AddPaymentFailure(
          decoded is Map
              ? decoded['message']?.toString() ?? 'Failed to add payment'
              : 'Unexpected server response',
        ));
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ADD PAYMENT ERROR ❌ $e');
      }
      emit(const AddPaymentFailure('Something went wrong'));
    }
  }
}
