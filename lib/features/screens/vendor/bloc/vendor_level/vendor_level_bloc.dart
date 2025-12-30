import 'dart:convert';
import 'package:bloc_login/features/screens/vendor/model/vendor_level_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'vendor_level_event.dart';
import 'vendor_level_state.dart';

class VendorLevelBloc extends Bloc<VendorLevelEvent, VendorLevelState> {
  VendorLevelBloc() : super(VendorLevelInitial()) {
    on<FetchVendorLevels>(_onFetchVendorLevels);
  }

  Future<void> _onFetchVendorLevels(
      FetchVendorLevels event,
      Emitter<VendorLevelState> emit,
      ) async {
    emit(VendorLevelLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/vendorLevelList'),
        headers: const {
          'Accept': 'application/json',
        },
        body: {
          'db_connection': 'erp_tata_steel_demo',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded['status'] == 200 &&
          decoded['data'] is List) {
        final levels = (decoded['data'] as List)
            .map((e) => VendorLevelModel.fromJson(e))
            .toList();

        emit(VendorLevelLoaded(levels));
      } else {
        emit(
          VendorLevelFailure(
            decoded['message'] ?? 'Failed to load vendor levels',
          ),
        );
      }
    } catch (e) {
      emit(const VendorLevelFailure('Something went wrong'));
    }
  }
}
