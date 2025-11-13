import 'package:bloc_login/features/screens/vendor/model/vendors_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class VendorsListStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialVendorsListState extends VendorsListStates {}

class LoadingVendorsListState extends VendorsListStates {}

class LoadedVendorsListState extends VendorsListStates {
  final VendorsList model;

  LoadedVendorsListState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureVendorsListState extends VendorsListStates {
  final String error;

  FailureVendorsListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorVendorsListState extends VendorsListStates {
  final String error;

  InternalServerErrorVendorsListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorVendorsListState extends VendorsListStates {
  final String error;

  ServerErrorVendorsListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
