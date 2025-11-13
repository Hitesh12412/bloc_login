import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class FetchEmployees extends EmployeeEvent {}

class FetchMoreEmployees extends EmployeeEvent {}
