import 'dart:convert';
import 'package:bloc_login/features/screens/product_module/model/brand_model_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'brand_event.dart';
import 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc() : super(BrandInitial()) {
    on<FetchBrandEvent>(_fetchBrands);
    on<SelectBrandEvent>(_selectBrand);
  }

  Future<void> _fetchBrands(
      FetchBrandEvent event,
      Emitter<BrandState> emit,
      ) async {
    emit(BrandLoading());
    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/getBrandsList'),
        headers: const {
          'Accept': 'application/json',
        },
        body: {
          'db_connection': 'erp_tata_steel_demo',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded['status'] == 200) {
        final list = (decoded['data'] as List)
            .map((e) => BrandModel.fromJson(e))
            .toList();

        emit(BrandLoaded(brands: list, selectedBrand: null));
      } else {
        emit(BrandFailure(
            decoded['message'] ?? 'Failed to load brands'));
      }
    } catch (_) {
      emit(BrandFailure('Failed to load brands'));
    }
  }

  void _selectBrand(
      SelectBrandEvent event,
      Emitter<BrandState> emit,
      ) {
    if (state is BrandLoaded) {
      final current = state as BrandLoaded;
      emit(BrandLoaded(
        brands: current.brands,
        selectedBrand: event.brand,
      ));
    }
  }
}
