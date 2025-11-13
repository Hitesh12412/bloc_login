import 'package:equatable/equatable.dart';

abstract class CustomerListEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCustomerListEvent extends CustomerListEvents {
  final String? pageNumber;
  final String? status;

  FetchCustomerListEvent({ this.pageNumber, this.status});

  @override
  List<Object?> get props => [ pageNumber, status];
}
