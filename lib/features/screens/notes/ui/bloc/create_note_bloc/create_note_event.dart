import 'package:equatable/equatable.dart';

abstract class NoteCreateEvent extends Equatable {
  const NoteCreateEvent();

  @override
  List<Object?> get props => [];
}

class NoteCreateRequested extends NoteCreateEvent {
  final String noteTitle;
  final String description;

  const NoteCreateRequested({
    required this.noteTitle,
    required this.description,
  });

  @override
  List<Object?> get props => [
    noteTitle,
    description,
  ];
}
