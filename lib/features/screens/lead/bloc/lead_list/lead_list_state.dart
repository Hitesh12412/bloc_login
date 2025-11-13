import 'package:bloc_login/features/screens/lead/model/lead_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class LeadListStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLeadListState extends LeadListStates {}

class LoadingLeadListState extends LeadListStates {}

class LoadedLeadListState extends LeadListStates {
  final LeadList model;

  LoadedLeadListState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureLeadListState extends LeadListStates {
  final String error;

  FailureLeadListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorLeadListState extends LeadListStates {
  final String error;

  InternalServerErrorLeadListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorLeadListState extends LeadListStates {
  final String error;

  ServerErrorLeadListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
