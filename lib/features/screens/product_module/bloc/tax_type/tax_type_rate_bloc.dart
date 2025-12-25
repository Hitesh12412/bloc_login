import 'dart:convert';
import 'package:bloc_login/features/screens/product_module/bloc/tax_type/tax_type_rate_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/tax_type/tax_type_rate_state.dart';
import 'package:bloc_login/features/screens/product_module/model/tax_type_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class TaxBloc extends Bloc<TaxEvent, TaxState> {
  TaxBloc() : super(TaxInitial()) {
    on<FetchTaxEvent>(_fetchTax);
    on<SelectTaxEvent>(_selectTax);
  }

  Future<void> _fetchTax(
      FetchTaxEvent event,
      Emitter<TaxState> emit,
      ) async {
    emit(TaxLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/getTaxTypeList'),
        headers: const {
          'Accept': 'application/json',
        },
        body: {
          'db_connection': 'erp_tata_steel_demo',
          'tax_type': event.taxType,
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded['status'] == 200) {
        final List<TaxTypeModel> list =
        (decoded['data'] as List)
            .map((e) => TaxTypeModel.fromJson(e))
            .toList();

        emit(TaxLoaded(taxes: list, selectedTax: null));
      } else {
        emit(TaxFailure(
            decoded['message'] ?? 'Failed to load tax list'));
      }
    } catch (_) {
      emit(TaxFailure('Failed to load tax list'));
    }
  }

  void _selectTax(
      SelectTaxEvent event,
      Emitter<TaxState> emit,
      ) {
    if (state is TaxLoaded) {
      final current = state as TaxLoaded;
      emit(TaxLoaded(
        taxes: current.taxes,
        selectedTax: event.tax,
      ));
    }
  }
}
