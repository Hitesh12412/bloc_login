import 'package:equatable/equatable.dart';

abstract class DispatchListEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDispatchListEvent extends DispatchListEvents {
  final String? DispatchCategoryId;
  final String? pageNumber;
  final String? status;

  FetchDispatchListEvent({this.DispatchCategoryId, this.pageNumber, this.status});

  @override
  List<Object?> get props => [DispatchCategoryId, pageNumber, status];
}
