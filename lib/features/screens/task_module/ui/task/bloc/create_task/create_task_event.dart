import 'package:equatable/equatable.dart';

abstract class TaskCreateEvent extends Equatable {
  const TaskCreateEvent();

  @override
  List<Object?> get props => [];
}

class TaskCreateRequested extends TaskCreateEvent {
  final String taskName;
  final String description;
  final String employeeId;
  final String startDate;
  final String endDate;
  final String taskPriority;

  const TaskCreateRequested({
    required this.taskName,
    required this.description,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.taskPriority,
  });

  @override
  List<Object?> get props => [
    taskName,
    description,
    employeeId,
    startDate,
    endDate,
    taskPriority,
  ];
}
