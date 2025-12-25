import 'package:bloc_login/features/screens/product_module/model/category_model_class.dart';


abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;

  CategoryLoaded({
    required this.categories,
    required this.selectedCategory,
  });
}

class CategoryFailure extends CategoryState {
  final String message;
  CategoryFailure(this.message);
}
