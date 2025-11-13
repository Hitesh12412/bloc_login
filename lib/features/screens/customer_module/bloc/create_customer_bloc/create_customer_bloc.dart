import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'create_customer_event.dart';
import 'create_customer_state.dart';

class CustomerCreateBloc extends Bloc<CustomerCreateEvent, CustomerCreateState> {
  CustomerCreateBloc() : super(CustomerCreateInitial()) {
    on<CustomerCreateRequested>(_onCreateCustomer);
  }

  Future<void> _onCreateCustomer(
    CustomerCreateRequested event,
    Emitter<CustomerCreateState> emit,
  ) async {
    emit(CustomerCreateLoading());
    try {
      final body = {
        'dbconnection': event.dbConnection,
        'customer_name': event.customerName,
        'email': event.email,
        'mobile_no': event.mobileNo,
        'whatsapp_no': event.whatsappNo ?? '',
        'gst_no': event.gstNo ?? '',
        'address': event.address,
        'user_id': event.userId,
        'customer_level_id': event.customerLevelId,
        'product_id': event.productId,
      };

      if (kDebugMode) {
        print('--- FINAL ATTEMPT: Create Customer Request ---');
        print('URL: https://shiserp.com/demo/api/createCustomer');
        print('Headers: {Content-Type: application/x-www-form-urlencoded}');
        print('Encoding: utf-8');
        print('Body: $body');
        print('-------------------------------------------');
      }

      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/createCustomer'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        encoding: Encoding.getByName('utf-8'),
        body: body,
      );

      if (kDebugMode) {
        print('--- FINAL ATTEMPT: Create Customer Response ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        print('-------------------------------------------');
      }

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 200) {
        emit(CustomerCreateSuccess(
            message: data['message'] ?? 'Customer created successfully'));
      } else {
        emit(CustomerCreateFailure(
            error: data['message'] ?? 'Server returned status ${data['status']}'));
      }
    } catch (e) {
      emit(CustomerCreateFailure(
          error: 'An unexpected client-side error occurred: $e'));
    }
  }
}
