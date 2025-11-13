import 'package:equatable/equatable.dart';

abstract class PaymentHistoryStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPaymentHistoryState extends PaymentHistoryStates {}

class LoadingPaymentHistoryState extends PaymentHistoryStates {}

class LoadedPaymentHistoryState extends PaymentHistoryStates {
  final PaymentHistoryListModel model;

  LoadedPaymentHistoryState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailurePaymentHistoryState extends PaymentHistoryStates {
  final String error;

  FailurePaymentHistoryState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorPaymentHistoryState extends PaymentHistoryStates {
  final String error;

  InternalServerErrorPaymentHistoryState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorPaymentHistoryState extends PaymentHistoryStates {
  final String error;

  ServerErrorPaymentHistoryState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
