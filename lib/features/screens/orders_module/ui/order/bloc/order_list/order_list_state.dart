import 'package:bloc_login/features/screens/orders_module/ui/order/model/order_list/oder_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrderStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialOrderState extends OrderStates {}

class LoadingOrderState extends OrderStates {
  final String? searchText;

  LoadingOrderState({this.searchText});

  @override
  List<Object?> get props => [searchText];
}

class LoadedOrderState extends OrderStates {
  final OrderListModel model;
  final String? searchText;

  LoadedOrderState({
    required this.model,
    this.searchText,
  });

  @override
  List<Object?> get props => [model, searchText];
}

class FailureOrderState extends OrderStates {
  final String error;
  final String? searchText;

  FailureOrderState({
    required this.error,
    this.searchText,
  });

  @override
  List<Object?> get props => [error, searchText];
}

class InternalServerErrorOrderState extends OrderStates {
  final String error;

  InternalServerErrorOrderState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

class ServerErrorOrderState extends OrderStates {
  final String error;

  ServerErrorOrderState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
