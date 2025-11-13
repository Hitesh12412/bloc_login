import 'package:equatable/equatable.dart';

abstract class AwardEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAwardEvent extends AwardEvents {
  final String employeeId;

  FetchAwardEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props => [employeeId,];
}
