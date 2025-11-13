import 'package:equatable/equatable.dart';

abstract class ProductDetailEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductDetailEvent extends ProductDetailEvents {
  final String productID;

  FetchProductDetailEvent({
    required this.productID,
  });

  @override
  List<Object> get props => [productID,];
}
