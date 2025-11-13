import 'package:bloc_login/features/screens/inventory/model/inevntory_product_list_model.dart';

abstract class InventoryListStates {}

class InitialInventoryListState extends InventoryListStates {}

class LoadingInventoryListState extends InventoryListStates {}

class LoadedInventoryListState extends InventoryListStates {
  final InventoryResponse inventoryResponse;

  LoadedInventoryListState({required this.inventoryResponse});
}

class FailureInventoryListState extends InventoryListStates {
  final String error;

  FailureInventoryListState({required this.error});
}

class InternalServerErrorInventoryListState extends InventoryListStates {
  final String error;

  InternalServerErrorInventoryListState({required this.error});
}

class ServerErrorInventoryListState extends InventoryListStates {
  final String error;

  ServerErrorInventoryListState({required this.error});
}
