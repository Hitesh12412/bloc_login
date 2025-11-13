import 'package:bloc_login/features/screens/support/model/support_model.dart';

abstract class SupportDetailStates {}

class InitialSupportDetailState extends SupportDetailStates {}

class LoadingSupportDetailState extends SupportDetailStates {}

class LoadedSupportDetailState extends SupportDetailStates {
  final SupportResponse model;

  LoadedSupportDetailState({required this.model});
}

class FailureSupportDetailState extends SupportDetailStates {
  final String error;

  FailureSupportDetailState({required this.error});
}

class InternalServerErrorSupportDetailState extends SupportDetailStates {
  final String error;

  InternalServerErrorSupportDetailState({required this.error});
}

class ServerErrorSupportDetailState extends SupportDetailStates {
  final String error;

  ServerErrorSupportDetailState({required this.error});
}
