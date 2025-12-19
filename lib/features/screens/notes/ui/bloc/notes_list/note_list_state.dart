import 'package:bloc_login/features/screens/notes/ui/model/notes_model.dart';
import 'package:equatable/equatable.dart';

abstract class NoteListStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialNoteListState extends NoteListStates {}

class LoadingNoteListState extends NoteListStates {}

class LoadedNoteListState extends NoteListStates {
  final NotesResponse model;

  LoadedNoteListState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureNoteListState extends NoteListStates {
  final String error;

  FailureNoteListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorNoteListState extends NoteListStates {
  final String error;

  InternalServerErrorNoteListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorNoteListState extends NoteListStates {
  final String error;

  ServerErrorNoteListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
