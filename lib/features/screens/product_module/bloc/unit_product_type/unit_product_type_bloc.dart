import 'dart:convert';
import 'package:bloc_login/features/screens/product_module/bloc/unit_product_type/unit_product_type_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/unit_product_type/unit_product_type_state.dart';
import 'package:bloc_login/features/screens/product_module/model/unit_and_product_type_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class UnitProductBloc
    extends Bloc<UnitProductEvent, UnitProductState> {
  UnitProductBloc() : super(UnitProductInitial()) {
    on<FetchUnitProductEvent>(_fetch);
    on<SelectUnitEvent>(_selectUnit);
    on<SelectProductTypeEvent>(_selectProductType);
  }

  Future<void> _fetch(
      FetchUnitProductEvent event,
      Emitter<UnitProductState> emit,
      ) async {
    emit(UnitProductLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/getUnitAndProductTypeList'),
        headers: const {
          'Accept': 'application/json',
        },
        body: {
          'db_connection': 'erp_tata_steel_demo',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded['status'] == 200) {
        final units =
        (decoded['data']['getUnitsList'] as List)
            .map((e) => UnitProductModel.fromJson(e))
            .toList();

        final productTypes =
        (decoded['data']['getProductTypeList'] as List)
            .map((e) => UnitProductModel.fromJson(e))
            .toList();

        emit(UnitProductLoaded(
          units: units,
          productTypes: productTypes,
          selectedUnit: null,
          selectedProductType: null,
        ));
      } else {
        emit(UnitProductFailure(
            decoded['message'] ?? 'Failed to load data'));
      }
    } catch (_) {
      emit(UnitProductFailure('Failed to load data'));
    }
  }

  void _selectUnit(
      SelectUnitEvent event,
      Emitter<UnitProductState> emit,
      ) {
    if (state is UnitProductLoaded) {
      final current = state as UnitProductLoaded;
      emit(UnitProductLoaded(
        units: current.units,
        productTypes: current.productTypes,
        selectedUnit: event.unit,
        selectedProductType: current.selectedProductType,
      ));
    }
  }

  void _selectProductType(
      SelectProductTypeEvent event,
      Emitter<UnitProductState> emit,
      ) {
    if (state is UnitProductLoaded) {
      final current = state as UnitProductLoaded;
      emit(UnitProductLoaded(
        units: current.units,
        productTypes: current.productTypes,
        selectedUnit: current.selectedUnit,
        selectedProductType: event.productType,
      ));
    }
  }
}
