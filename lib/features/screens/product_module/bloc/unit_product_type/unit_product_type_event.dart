import '../../model/unit_and_product_type_model.dart';

abstract class UnitProductEvent {}

class FetchUnitProductEvent extends UnitProductEvent {}

class SelectUnitEvent extends UnitProductEvent {
  final UnitProductModel unit;
  SelectUnitEvent(this.unit);
}

class SelectProductTypeEvent extends UnitProductEvent {
  final UnitProductModel productType;
  SelectProductTypeEvent(this.productType);
}
