
import 'package:bloc_login/features/screens/product_module/model/brand_model_class.dart';

abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<BrandModel> brands;
  final BrandModel? selectedBrand;

  BrandLoaded({
    required this.brands,
    required this.selectedBrand,
  });
}

class BrandFailure extends BrandState {
  final String message;
  BrandFailure(this.message);
}
