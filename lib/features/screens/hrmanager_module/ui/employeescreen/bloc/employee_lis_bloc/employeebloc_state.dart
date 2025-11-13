import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/model/employee_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;
  final bool hasReachedMax;
  final double pendingSalary;

  const EmployeeLoaded(
      this.employees, {
        this.hasReachedMax = false,
        this.pendingSalary = 0.0,
      });

  @override
  List<Object> get props => [employees, hasReachedMax, pendingSalary];

  EmployeeLoaded copyWith({
    List<Employee>? employees,
    bool? hasReachedMax,
    double? pendingSalary,
  }) {
    return EmployeeLoaded(
      employees ?? this.employees,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pendingSalary: pendingSalary ?? this.pendingSalary,
    );
  }
}

class EmployeeError extends EmployeeState {
  final String message;
  const EmployeeError(this.message);

  @override
  List<Object> get props => [message];
}
