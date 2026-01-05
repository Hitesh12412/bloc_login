abstract class AddPaymentState {
  const AddPaymentState();
}

class AddPaymentInitial extends AddPaymentState {
  const AddPaymentInitial();
}

class AddPaymentLoading extends AddPaymentState {
  const AddPaymentLoading();
}

class AddPaymentSuccess extends AddPaymentState {
  final String message;

  const AddPaymentSuccess(this.message);
}

class AddPaymentFailure extends AddPaymentState {
  final String error;

  const AddPaymentFailure(this.error);
}
