import 'package:equatable/equatable.dart';

abstract class OrderCreateState extends Equatable {
  const OrderCreateState();

  @override
  List<Object?> get props => [];
}

class OrderCreateInitial extends OrderCreateState {}

class OrderCreateLoading extends OrderCreateState {}

class OrderCreateSuccess extends OrderCreateState {
  final String message;
  const OrderCreateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderCreateFailure extends OrderCreateState {
  final String error;
  const OrderCreateFailure(this.error);

  @override
  List<Object?> get props => [error];
}
