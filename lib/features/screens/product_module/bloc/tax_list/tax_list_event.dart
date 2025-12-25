import 'package:bloc_login/features/screens/product_module/model/tax_list.dart';

abstract class TaxEvent {}

class FetchTaxEvent extends TaxEvent {}

class SelectTaxEvent extends TaxEvent {
  final TaxModel tax;
  SelectTaxEvent(this.tax);
}
