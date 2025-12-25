import 'dart:convert';
import 'package:bloc_login/features/screens/product_module/model/category_model_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategoryEvent>(_onFetchCategory);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onFetchCategory(
      FetchCategoryEvent event,
      Emitter<CategoryState> emit,
      ) async {
    emit(CategoryLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/getCategoryList'),
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
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        emit(CategoryLoaded(
          categories: list,
          selectedCategory: null,
        ));
      } else {
        emit(CategoryFailure(
            decoded['message'] ?? 'Failed to load category'));
      }
    } catch (e) {
      emit(CategoryFailure('Failed to load category'));
    }
  }


  void _onSelectCategory(
      SelectCategoryEvent event,
      Emitter<CategoryState> emit,
      ) {
    if (state is CategoryLoaded) {
      final current = state as CategoryLoaded;
      emit(CategoryLoaded(
        categories: current.categories,
        selectedCategory: event.category,
      ));
    }
  }
}
