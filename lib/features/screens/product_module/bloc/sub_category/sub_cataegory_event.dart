import 'package:bloc_login/features/screens/product_module/model/sub_category_class.dart';

abstract class SubCategoryEvent {}

class FetchSubCategoryEvent extends SubCategoryEvent {
  final String categoryId;
  FetchSubCategoryEvent(this.categoryId);
}

class SelectSubCategoryEvent extends SubCategoryEvent {
  final SubCategoryModel subCategory;
  SelectSubCategoryEvent(this.subCategory);
}
