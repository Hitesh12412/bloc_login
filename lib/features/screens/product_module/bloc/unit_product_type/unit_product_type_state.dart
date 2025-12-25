
import 'package:bloc_login/features/screens/product_module/model/unit_and_product_type_model.dart';

abstract class UnitProductState {}

class UnitProductInitial extends UnitProductState {}

class UnitProductLoading extends UnitProductState {}

class UnitProductLoaded extends UnitProductState {
  final List<UnitProductModel> units;
  final List<UnitProductModel> productTypes;
  final UnitProductModel? selectedUnit;
  final UnitProductModel? selectedProductType;

  UnitProductLoaded({
    required this.units,
    required this.productTypes,
    required this.selectedUnit,
    required this.selectedProductType,
  });
}

class UnitProductFailure extends UnitProductState {
  final String message;
  UnitProductFailure(this.message);
}
