import 'package:equatable/equatable.dart';

abstract class CreateAgreementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateAgreementInitial extends CreateAgreementState {}

class CreateAgreementLoading extends CreateAgreementState {}

class CreateAgreementSuccess extends CreateAgreementState {}

class CreateAgreementFailure extends CreateAgreementState {
  final String error;

  CreateAgreementFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
