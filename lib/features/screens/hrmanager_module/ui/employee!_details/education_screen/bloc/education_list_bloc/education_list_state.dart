import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/education_screen/model/education_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class EducationStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialEducationState extends EducationStates {}

class LoadingEducationState extends EducationStates {}

class LoadedEducationState extends EducationStates {
  final EducationListModel model;

  LoadedEducationState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureEducationState extends EducationStates {
  final String error;

  FailureEducationState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorEducationState extends EducationStates {
  final String error;

  InternalServerErrorEducationState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorEducationState extends EducationStates {
  final String error;

  ServerErrorEducationState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
