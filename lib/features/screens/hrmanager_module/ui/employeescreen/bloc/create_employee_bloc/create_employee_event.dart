import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class CreateEmployeeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitCreateEmployeeEvent extends CreateEmployeeEvent {
  final String name;
  final String designation;
  final String dateOfBirth;
  final String dateOfJoining;
  final String email;
  final String mobileNo;
  final String employeeCode;
  final File? profilePicture;

  SubmitCreateEmployeeEvent({
    required this.name,
    required this.designation,
    required this.dateOfBirth,
    required this.dateOfJoining,
    required this.email,
    required this.mobileNo,
    required this.employeeCode,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [name, designation, dateOfBirth, dateOfJoining, email, mobileNo, employeeCode, profilePicture];
}

