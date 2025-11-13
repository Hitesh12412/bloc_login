import 'package:bloc_login/features/screens/task_module/ui/task/model/task_list_model/task_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class TaskStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialTaskState extends TaskStates {}

class LoadingTaskState extends TaskStates {}

class LoadedTaskState extends TaskStates {
  final TaskListModel model;

  LoadedTaskState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureTaskState extends TaskStates {
  final String error;

  FailureTaskState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorTaskState extends TaskStates {
  final String error;

  InternalServerErrorTaskState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorTaskState extends TaskStates {
  final String error;

  ServerErrorTaskState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
