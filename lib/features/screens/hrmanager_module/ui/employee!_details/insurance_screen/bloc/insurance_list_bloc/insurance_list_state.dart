import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/insurance_screen/model/insurance_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class InsuranceStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialInsuranceState extends InsuranceStates {}

class LoadingInsuranceState extends InsuranceStates {}

class LoadedInsuranceState extends InsuranceStates {
  final InsuranceListModel model;

  LoadedInsuranceState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureInsuranceState extends InsuranceStates {
  final String error;

  FailureInsuranceState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorInsuranceState extends InsuranceStates {
  final String error;

  InternalServerErrorInsuranceState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorInsuranceState extends InsuranceStates {
  final String error;

  ServerErrorInsuranceState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
