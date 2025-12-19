import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/notes/ui/bloc/notes_list/note_list_event.dart';
import 'package:bloc_login/features/screens/notes/ui/bloc/notes_list/note_list_state.dart';
import 'package:bloc_login/features/screens/notes/ui/model/notes_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class NoteListBloc extends Bloc<NoteListEvents, NoteListStates> {
  NoteListBloc() : super(InitialNoteListState()) {
    on<FetchNoteListEvent>((event, emit) async {
      emit(LoadingNoteListState());
      try {
        NotesResponse model = await fetchNoteList(
          userId: '1',
        );

        if (model.status == 200) {
          emit(LoadedNoteListState(model: model));
        }
        else {
          emit(FailureNoteListState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorNoteListState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorNoteListState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureNoteListState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<NotesResponse> fetchNoteList({
    required String userId,
  }) async {
    final data = {
      'user_id': "1",
      'db_connection': "erp_tata_steel_demo",
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/noteList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return NotesResponse.fromJsonMap(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
