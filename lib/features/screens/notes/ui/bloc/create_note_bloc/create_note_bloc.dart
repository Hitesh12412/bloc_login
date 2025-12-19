import 'dart:convert';
import 'package:bloc_login/features/screens/notes/ui/bloc/create_note_bloc/create_note_event.dart';
import 'package:bloc_login/features/screens/notes/ui/bloc/create_note_bloc/create_note_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class NoteCreateBloc extends Bloc<NoteCreateEvent, NoteCreateState> {
  NoteCreateBloc() : super(NoteCreateInitial()) {
    on<NoteCreateRequested>((event, emit) async {
      emit(NoteCreateLoading());
      try {
        final data = {
          'user_id': '1',
          'db_connection': 'erp_tata_steel_demo',
          'title': event.noteTitle,
          'description': event.description,
        };
        if (kDebugMode) {
          print('CreateNote POST: $data');
        }

        final Uri url = Uri.parse("https://shiserp.com/demo/api/noteCreate");
        final response = await http.post(url, body: data);
        final decode = json.decode(response.body);

        if (response.statusCode == 200 && decode['status'] == 200) {
          emit(NoteCreateSuccess(decode['message'] ?? "Note created successfully"));
        } else {
          emit(NoteCreateFailure(decode['message'] ?? "Failed to create Note"));
        }
      } catch (e) {
        emit(NoteCreateFailure("An error occurred: $e"));
      }
    });
  }
}

