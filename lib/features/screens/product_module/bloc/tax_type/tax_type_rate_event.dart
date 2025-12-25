import 'package:bloc_login/features/screens/product_module/model/tax_type_model.dart';

abstract class TaxEvent {}

class FetchTaxEvent extends TaxEvent {
  final String taxType;
  FetchTaxEvent(this.taxType);
}

class SelectTaxEvent extends TaxEvent {
  final TaxTypeModel tax;
  SelectTaxEvent(this.tax);
}
