import 'package:equatable/equatable.dart';

abstract class TaskCreateState extends Equatable {
  const TaskCreateState();

  @override
  List<Object?> get props => [];
}

class TaskCreateInitial extends TaskCreateState {}

class TaskCreateLoading extends TaskCreateState {}

class TaskCreateSuccess extends TaskCreateState {
  final String message;
  const TaskCreateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TaskCreateFailure extends TaskCreateState {
  final String error;
  const TaskCreateFailure(this.error);

  @override
  List<Object?> get props => [error];
}
