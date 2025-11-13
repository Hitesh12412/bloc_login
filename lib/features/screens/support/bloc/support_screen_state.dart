import 'package:bloc_login/features/screens/support/model/support_model.dart';

abstract class SupportListStates {}

class InitialSupportListState extends SupportListStates {}

class LoadingSupportListState extends SupportListStates {}

class LoadedSupportListState extends SupportListStates {
  final SupportResponse model;

  LoadedSupportListState({required this.model});
}

class FailureSupportListState extends SupportListStates {
  final String error;

  FailureSupportListState({required this.error});
}

class InternalServerErrorSupportListState extends SupportListStates {
  final String error;

  InternalServerErrorSupportListState({required this.error});
}

class ServerErrorSupportListState extends SupportListStates {
  final String error;

  ServerErrorSupportListState({required this.error});
}
