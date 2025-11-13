import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/model/kyc_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class KycStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialKycState extends KycStates {}

class LoadingKycState extends KycStates {}

class LoadedKycState extends KycStates {
  final KycListModel model;

  LoadedKycState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureKycState extends KycStates {
  final String error;

  FailureKycState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorKycState extends KycStates {
  final String error;

  InternalServerErrorKycState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorKycState extends KycStates {
  final String error;

  ServerErrorKycState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
