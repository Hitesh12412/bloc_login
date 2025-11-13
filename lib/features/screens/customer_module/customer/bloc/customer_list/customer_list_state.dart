import 'package:bloc_login/features/screens/customer_module/customer/model/customer_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class CustomerListStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialCustomerListState extends CustomerListStates {}

class LoadingCustomerListState extends CustomerListStates {}

class LoadedCustomerListState extends CustomerListStates {
  final CustomerList model;

  LoadedCustomerListState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureCustomerListState extends CustomerListStates {
  final String error;

  FailureCustomerListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorCustomerListState extends CustomerListStates {
  final String error;

  InternalServerErrorCustomerListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorCustomerListState extends CustomerListStates {
  final String error;

  ServerErrorCustomerListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
