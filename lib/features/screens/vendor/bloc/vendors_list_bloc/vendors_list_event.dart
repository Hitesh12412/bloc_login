import 'package:equatable/equatable.dart';

abstract class VendorsListEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchVendorsListEvent extends VendorsListEvents {
  final String? pageNumber;
  final String? status;

  FetchVendorsListEvent({ this.pageNumber, this.status});

  @override
  List<Object?> get props => [ pageNumber, status];
}
