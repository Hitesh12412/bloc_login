import 'package:equatable/equatable.dart';

abstract class ExperienceEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchExperienceEvent extends ExperienceEvents {
  final String employeeId;

  FetchExperienceEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props => [employeeId,];
}
