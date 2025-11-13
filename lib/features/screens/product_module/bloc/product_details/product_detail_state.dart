import 'package:bloc_login/features/screens/product_module/model/product_details_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialProductDetailState extends ProductDetailStates {}

class LoadingProductDetailState extends ProductDetailStates {}

class LoadedProductDetailState extends ProductDetailStates {
  final ProductDetailModel model;

  LoadedProductDetailState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureProductDetailState extends ProductDetailStates {
  final String error;

  FailureProductDetailState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorProductDetailState extends ProductDetailStates {
  final String error;

  InternalServerErrorProductDetailState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorProductDetailState extends ProductDetailStates {
  final String error;

  ServerErrorProductDetailState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
