import 'package:equatable/equatable.dart';

abstract class TaskDeleteEvent extends Equatable {
  const TaskDeleteEvent();

  @override
  List<Object?> get props => [];
}

class DeleteButtonPressedForTaskEvent extends TaskDeleteEvent {
  final int taskId;

  const DeleteButtonPressedForTaskEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
