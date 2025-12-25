
import 'package:bloc_login/features/screens/product_module/model/tax_type_model.dart';

abstract class TaxState {}

class TaxInitial extends TaxState {}

class TaxLoading extends TaxState {}

class TaxLoaded extends TaxState {
  final List<TaxTypeModel> taxes;
  final TaxTypeModel? selectedTax;

  TaxLoaded({
    required this.taxes,
    required this.selectedTax,
  });
}

class TaxFailure extends TaxState {
  final String message;
  TaxFailure(this.message);
}
