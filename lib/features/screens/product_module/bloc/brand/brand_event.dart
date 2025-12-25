import '../../model/brand_model_class.dart';

abstract class BrandEvent {}

class FetchBrandEvent extends BrandEvent {}

class SelectBrandEvent extends BrandEvent {
  final BrandModel brand;
  SelectBrandEvent(this.brand);
}
