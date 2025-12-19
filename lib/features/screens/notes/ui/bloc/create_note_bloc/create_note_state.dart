import 'package:equatable/equatable.dart';

abstract class NoteCreateState extends Equatable {
  const NoteCreateState();

  @override
  List<Object?> get props => [];
}

class NoteCreateInitial extends NoteCreateState {}

class NoteCreateLoading extends NoteCreateState {}

class NoteCreateSuccess extends NoteCreateState {
  final String message;
  const NoteCreateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class NoteCreateFailure extends NoteCreateState {
  final String error;
  const NoteCreateFailure(this.error);

  @override
  List<Object?> get props => [error];
}
