import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'create_order_event.dart';
import 'create_order_state.dart';

class OrderCreateBloc extends Bloc<OrderCreateEvent, OrderCreateState> {
  OrderCreateBloc() : super(OrderCreateInitial()) {
    on<OrderCreateRequested>(_onCreateOrder);
  }

  Future<void> _onCreateOrder(
      OrderCreateRequested event,
      Emitter<OrderCreateState> emit,
      ) async {
    emit(OrderCreateLoading());

    try {
      final Map<String, String> data = {
        'user_id': event.userId,
        'db_connection': 'erp_tata_steel_demo',

        'customer_id': event.customerId,
        'branch_id': event.branchId,

        'customer_name': event.customerName,
        'email': event.email,
        'mobile_no': event.mobileNo,
        'address': event.address,

        'billing_address': event.billingAddress,
        'billing_country_id': event.billingCountryId,
        'billing_state_id': event.billingStateId,
        'billing_city_id': event.billingCityId,
        'billing_pincode': event.billingPincode,

        'shipping_address': event.shippingAddress,
        'shipping_country_id': event.shippingCountryId,
        'shipping_state_id': event.shippingStateId,
        'shipping_city_id': event.shippingCityId,
        'shipping_pincode': event.shippingPincode,

        'description': event.description,
        'orderproduct_data': event.orderProductData,
      };

      if (event.leadId != null && event.leadId!.isNotEmpty) {
        data['lead_id'] = event.leadId!;
      }

      if (kDebugMode) {
        debugPrint('CREATE ORDER PAYLOAD 👉 ${jsonEncode(data)}');
      }

      final response = await http
          .post(
        Uri.parse('https://shiserp.com/demo/api/createOrder'),
        headers: const {
          'Accept': 'application/json',
        },
        body: data,
      )
          .timeout(const Duration(seconds: 20));

      final decode = json.decode(response.body);

      if (response.statusCode == 200 && decode['status'] == 200) {
        emit(
          OrderCreateSuccess(
            decode['message'] ?? 'Order created successfully',
          ),
        );
      } else {
        emit(
          OrderCreateFailure(
            decode['message'] ?? 'Failed to create order',
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('CREATE ORDER ERROR ❌ $e');
      }
      emit(const OrderCreateFailure('Something went wrong'));
    }
  }
}
