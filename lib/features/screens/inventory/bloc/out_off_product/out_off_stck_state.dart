import 'package:bloc_login/features/screens/inventory/model/out_off_product_model.dart';

abstract class OutOfStockStates {}

class InitialOutOfStockState extends OutOfStockStates {}

class LoadingOutOfStockState extends OutOfStockStates {}

class LoadedOutOfStockState extends OutOfStockStates {
  final OutOfStockResponse outOfStockResponse;

  LoadedOutOfStockState({required this.outOfStockResponse});
}

class FailureOutOfStockState extends OutOfStockStates {
  final String error;

  FailureOutOfStockState({required this.error});
}

class InternalServerErrorOutOfStockState extends OutOfStockStates {
  final String error;

  InternalServerErrorOutOfStockState({required this.error});
}

class ServerErrorOutOfStockState extends OutOfStockStates {
  final String error;

  ServerErrorOutOfStockState({required this.error});
}
