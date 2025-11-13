import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/model/agreement_list_model/agreement_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class AgreementStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAgreementState extends AgreementStates {}

class LoadingAgreementState extends AgreementStates {}

class LoadedAgreementState extends AgreementStates {
  final AgreementListModel model;

  LoadedAgreementState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureAgreementState extends AgreementStates {
  final String error;

  FailureAgreementState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorAgreementState extends AgreementStates {
  final String error;

  InternalServerErrorAgreementState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorAgreementState extends AgreementStates {
  final String error;

  ServerErrorAgreementState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
