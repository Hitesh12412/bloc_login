import 'package:equatable/equatable.dart';

abstract class KycEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchKycEvent extends KycEvents {
  final String employeeId;

  FetchKycEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props => [employeeId,];
}
