
abstract class ProductCreateState {
  const ProductCreateState();
}

class ProductCreateInitial extends ProductCreateState {
  const ProductCreateInitial();
}

class ProductCreateLoading extends ProductCreateState {
  const ProductCreateLoading();
}

class ProductCreateSuccess extends ProductCreateState {
  final String message;
  const ProductCreateSuccess(this.message);
}

class ProductCreateFailure extends ProductCreateState {
  final String message;
  const ProductCreateFailure(this.message);
}
