import 'package:equatable/equatable.dart';

abstract class TaskDeleteState extends Equatable {
  const TaskDeleteState();

  @override
  List<Object?> get props => [];
}

class InitialDeleteTaskState extends TaskDeleteState {}

class LoadingDeleteTaskState extends TaskDeleteState {}

class LoadedDeleteTaskState extends TaskDeleteState {
  final String message;
  const LoadedDeleteTaskState({required this.message});

  @override
  List<Object?> get props => [message];
}

class FailureDeleteTaskState extends TaskDeleteState {
  final String error;
  const FailureDeleteTaskState({required this.error});

  @override
  List<Object?> get props => [error];
}
