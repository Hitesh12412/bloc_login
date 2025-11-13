import 'package:equatable/equatable.dart';

abstract class InsuranceEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchInsuranceEvent extends InsuranceEvents {
  final String employeeId;

  FetchInsuranceEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props => [employeeId,];
}
