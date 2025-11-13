import 'package:equatable/equatable.dart';

abstract class AgreementEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAgreementEvent extends AgreementEvents {
  final String employeeId;

  FetchAgreementEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props => [employeeId,];
}
