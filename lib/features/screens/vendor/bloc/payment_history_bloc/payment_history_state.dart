import 'package:bloc_login/features/screens/vendor/model/payment_history_model.dart';

abstract class PaymentHistoryState {}

class PaymentHistoryInitial extends PaymentHistoryState {}

class PaymentHistoryLoading extends PaymentHistoryState {}

class PaymentHistoryLoaded extends PaymentHistoryState {
  final List<VendorPayment> vendors;
  PaymentHistoryLoaded(this.vendors);
}

class PaymentHistoryError extends PaymentHistoryState {
  final String message;
  PaymentHistoryError(this.message);
}
