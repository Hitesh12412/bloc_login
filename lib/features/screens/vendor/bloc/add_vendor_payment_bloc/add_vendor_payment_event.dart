abstract class AddPaymentEvent {
  const AddPaymentEvent();
}

class AddPaymentRequested extends AddPaymentEvent {
  final int userId;
  final int vendorId;
  final String date;
  final String collectedPayment;
  final String paymentMethod;
  final String remarks;

  const AddPaymentRequested({
    required this.userId,
    required this.vendorId,
    required this.date,
    required this.collectedPayment,
    required this.paymentMethod,
    required this.remarks,
  });
}
