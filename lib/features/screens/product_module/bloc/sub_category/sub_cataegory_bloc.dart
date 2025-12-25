import 'dart:convert';
import 'package:bloc_login/features/screens/product_module/bloc/sub_category/sub_cataegory_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/sub_category/sub_cataegory_state.dart';
import 'package:bloc_login/features/screens/product_module/model/sub_category_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class SubCategoryBloc
    extends Bloc<SubCategoryEvent, SubCategoryState> {
  SubCategoryBloc() : super(SubCategoryInitial()) {
    on<FetchSubCategoryEvent>(_fetch);
    on<SelectSubCategoryEvent>(_select);
  }

  Future<void> _fetch(
      FetchSubCategoryEvent event,
      Emitter<SubCategoryState> emit,
      ) async {
    emit(SubCategoryLoading());
    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/getSubCategoryList'),
        headers: const {
          'Accept': 'application/json',
        },
        body: {
          'db_connection': 'erp_tata_steel_demo',
          'category_id': event.categoryId,
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded['status'] == 200) {
        final list = (decoded['data'] as List)
            .map((e) => SubCategoryModel.fromJson(e))
            .toList();

        emit(SubCategoryLoaded(list: list, selected: null));
      } else {
        emit(SubCategoryFailure(
            decoded['message'] ?? 'Failed to load sub category'));
      }
    } catch (_) {
      emit(SubCategoryFailure('Failed to load sub category'));
    }
  }

  void _select(
      SelectSubCategoryEvent event,
      Emitter<SubCategoryState> emit,
      ) {
    if (state is SubCategoryLoaded) {
      final current = state as SubCategoryLoaded;
      emit(SubCategoryLoaded(
        list: current.list,
        selected: event.subCategory,
      ));
    }
  }
}
