import 'package:equatable/equatable.dart';

abstract class EducationEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEducationEvent extends EducationEvents {
  final String employeeId;

  FetchEducationEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props => [employeeId,];
}
