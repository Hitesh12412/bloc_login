
import 'package:bloc_login/features/screens/product_module/model/sub_category_class.dart';

abstract class SubCategoryState {}

class SubCategoryInitial extends SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategoryLoaded extends SubCategoryState {
  final List<SubCategoryModel> list;
  final SubCategoryModel? selected;

  SubCategoryLoaded({
    required this.list,
    required this.selected,
  });
}

class SubCategoryFailure extends SubCategoryState {
  final String message;
  SubCategoryFailure(this.message);
}
