import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class CreateAgreementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitAgreementEvent extends CreateAgreementEvent {
  final String employeeId;
  final String associationType;
  final String startDate;
  final String endDate;
  final String dueDate;
  final File? document;

  SubmitAgreementEvent({
    required this.employeeId,
    required this.associationType,
    required this.startDate,
    required this.endDate,
    required this.dueDate,
    required this.document,
  });

  @override
  List<Object?> get props => [
    employeeId,
    associationType,
    startDate,
    endDate,
    dueDate,
    document,
  ];
}
