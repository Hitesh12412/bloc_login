import 'package:equatable/equatable.dart';
import 'package:bloc_login/features/screens/product_module/model/products_list_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductListModel> products;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final int totalCount;

  ProductLoaded({
    required this.products,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [products, currentPage, totalPages, hasNextPage, totalCount];
}

class ProductError extends ProductState {
  final String message;
  ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}
