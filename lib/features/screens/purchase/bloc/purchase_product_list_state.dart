
import 'package:bloc_login/features/screens/purchase/model/product_model.dart';

abstract class PurchaseListStates {}

class InitialPurchaseListState extends PurchaseListStates {}

class LoadingPurchaseListState extends PurchaseListStates {}

class LoadedPurchaseListState extends PurchaseListStates {
  final PurchaseResponse model;

  LoadedPurchaseListState({required this.model});
}

class FailurePurchaseListState extends PurchaseListStates {
  final String error;

  FailurePurchaseListState({required this.error});
}

class InternalServerErrorPurchaseListState extends PurchaseListStates {
  final String error;

  InternalServerErrorPurchaseListState({required this.error});
}

class ServerErrorPurchaseListState extends PurchaseListStates {
  final String error;

  ServerErrorPurchaseListState({required this.error});
}
