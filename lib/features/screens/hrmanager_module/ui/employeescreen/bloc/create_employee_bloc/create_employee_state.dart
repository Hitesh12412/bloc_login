import 'package:equatable/equatable.dart';

abstract class CreateEmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateEmployeeInitial extends CreateEmployeeState {}

class CreateEmployeeLoading extends CreateEmployeeState {}

class CreateEmployeeSuccess extends CreateEmployeeState {}

class CreateEmployeeFailure extends CreateEmployeeState {
  final String error;

  CreateEmployeeFailure(this.error);

  @override
  List<Object?> get props => [error];
}
