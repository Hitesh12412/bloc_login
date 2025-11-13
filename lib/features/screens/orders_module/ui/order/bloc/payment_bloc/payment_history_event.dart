import 'package:equatable/equatable.dart';

abstract class PaymentHistoryEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPaymentHistoryEvent extends PaymentHistoryEvents {
  final String userId;

  FetchPaymentHistoryEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId,];
}
