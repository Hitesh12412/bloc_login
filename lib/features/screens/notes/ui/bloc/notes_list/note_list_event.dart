import 'package:equatable/equatable.dart';

abstract class NoteListEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNoteListEvent extends NoteListEvents {
  final String userId;

  FetchNoteListEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId,];
}
