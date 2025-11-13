import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/experience_screen/model/exp_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class ExperienceStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialExperienceState extends ExperienceStates {}

class LoadingExperienceState extends ExperienceStates {}

class LoadedExperienceState extends ExperienceStates {
  final ExperienceListModel model;

  LoadedExperienceState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureExperienceState extends ExperienceStates {
  final String error;

  FailureExperienceState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorExperienceState extends ExperienceStates {
  final String error;

  InternalServerErrorExperienceState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorExperienceState extends ExperienceStates {
  final String error;

  ServerErrorExperienceState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
