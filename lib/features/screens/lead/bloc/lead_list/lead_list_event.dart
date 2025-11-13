import 'package:equatable/equatable.dart';

abstract class LeadListEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchLeadListEvent extends LeadListEvents {
  final String? leadCategoryId;
  final String? pageNumber;
  final String? status;

  FetchLeadListEvent({this.leadCategoryId, this.pageNumber, this.status});

  @override
  List<Object?> get props => [leadCategoryId, pageNumber, status];
}
