import 'package:equatable/equatable.dart';

abstract class CustomerCreateState extends Equatable {
  const CustomerCreateState();

  @override
  List<Object> get props => [];
}

class CustomerCreateInitial extends CustomerCreateState {}

class CustomerCreateLoading extends CustomerCreateState {}

class CustomerCreateSuccess extends CustomerCreateState {
  final String message;

  const CustomerCreateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class CustomerCreateFailure extends CustomerCreateState {
  final String error;

  const CustomerCreateFailure({required this.error});

  @override
  List<Object> get props => [error];
}
