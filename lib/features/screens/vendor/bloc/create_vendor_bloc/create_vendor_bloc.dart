import 'dart:convert';
import 'package:bloc_login/features/screens/vendor/bloc/create_vendor_bloc/create_vendor_event.dart';
import 'package:bloc_login/features/screens/vendor/bloc/create_vendor_bloc/create_vendor_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class VendorCreateBloc extends Bloc<VendorCreateEvent, VendorCreateState> {
  VendorCreateBloc() : super(const VendorCreateInitial()) {
    on<VendorCreateRequested>(_onCreateVendor);
  }

  Future<void> _onCreateVendor(
      VendorCreateRequested event,
      Emitter<VendorCreateState> emit,
      ) async {
    emit(const VendorCreateLoading());

    final body = {
      'user_id': event.userId,
      'db_connection': 'erp_tata_steel_demo',
      'vendor_name': event.vendorName,
      'vendor_company_name': event.vendorCompanyName,
      'vendor_email': event.vendorEmail,
      'mobile_number': event.mobileNumber,
      'whatsapp_no': event.whatsappNumber,
      'gst_no': event.gstNumber,
      'address': event.address,
      'vendor_level_id': event.vendorLevelId,
      'branch_id': event.branchId,
      'product_id': event.productId,
    };

    if (kDebugMode) {
      debugPrint('CREATE VENDOR BODY 👉 $body');
    }

    try {
      final response = await http
          .post(
        Uri.parse('https://shiserp.com/demo/api/createVendor'),
        headers: const {
          'Accept': 'application/json',
        },
        body: body,
      )
          .timeout(const Duration(seconds: 20));

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded is Map &&
          decoded['status'] == 200) {
        emit(
          VendorCreateSuccess(
            decoded['message']?.toString() ??
                'Vendor created successfully',
          ),
        );
      } else {
        emit(
          VendorCreateFailure(
            decoded is Map
                ? decoded['message']?.toString() ??
                'Failed to create Vendor'
                : 'Unexpected server response',
          ),
        );
      }
    } on http.ClientException {
      emit(const VendorCreateFailure('Network error'));
    } on FormatException {
      emit(const VendorCreateFailure('Invalid server response'));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('CREATE VENDOR ERROR ❌ $e');
      }
      emit(const VendorCreateFailure('Something went wrong'));
    }
  }
}
