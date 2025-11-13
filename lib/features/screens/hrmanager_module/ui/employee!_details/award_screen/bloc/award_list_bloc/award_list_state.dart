import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/award_screen/model/award_list_model/award_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class AwardStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAwardState extends AwardStates {}

class LoadingAwardState extends AwardStates {}

class LoadedAwardState extends AwardStates {
  final AwardListModel model;

  LoadedAwardState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureAwardState extends AwardStates {
  final String error;

  FailureAwardState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorAwardState extends AwardStates {
  final String error;

  InternalServerErrorAwardState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorAwardState extends AwardStates {
  final String error;

  ServerErrorAwardState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
