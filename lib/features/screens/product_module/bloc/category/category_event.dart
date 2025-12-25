import 'package:bloc_login/features/screens/product_module/model/category_model_class.dart';


abstract class CategoryEvent {}

class FetchCategoryEvent extends CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final CategoryModel category;
  SelectCategoryEvent(this.category);
}
