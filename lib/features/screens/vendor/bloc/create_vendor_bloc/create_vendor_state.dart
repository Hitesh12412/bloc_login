
abstract class VendorCreateState {
  const VendorCreateState();
}

class VendorCreateInitial extends VendorCreateState {
  const VendorCreateInitial();
}

class VendorCreateLoading extends VendorCreateState {
  const VendorCreateLoading();
}

class VendorCreateSuccess extends VendorCreateState {
  final String message;
  const VendorCreateSuccess(this.message);
}

class VendorCreateFailure extends VendorCreateState {
  final String message;
  const VendorCreateFailure(this.message);
}
