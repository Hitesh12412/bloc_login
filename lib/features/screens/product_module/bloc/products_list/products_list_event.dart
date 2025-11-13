import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductEvent {
  final String dbConnection;
  final String searchText;
  final int pageNumber;
  final int pageSize;

  FetchProducts({
    required this.dbConnection,
    required this.searchText,
    required this.pageNumber,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [dbConnection, searchText, pageNumber, pageSize];
}

class FetchMoreProducts extends ProductEvent {
  final String dbConnection;
  final String searchText;
  final int pageNumber;
  final int pageSize;

  FetchMoreProducts({
    required this.dbConnection,
    required this.searchText,
    required this.pageNumber,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [dbConnection, searchText, pageNumber, pageSize];
}
