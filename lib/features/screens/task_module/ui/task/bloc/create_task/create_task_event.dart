abstract class TaskCreateEvent {}

class TaskCreateRequested extends TaskCreateEvent {
  final String taskName;
  final String description;
  final String employeeId;
  final String taskPriority;
  final String startDate;
  final String endDate;

  TaskCreateRequested({
    required this.taskName,
    required this.description,
    required this.employeeId,
    required this.taskPriority,
    required this.startDate,
    required this.endDate,
  });
}
