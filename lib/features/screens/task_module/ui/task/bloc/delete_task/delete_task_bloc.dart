import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'delete_task_event.dart';
import 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<TaskDeleteEvent, TaskDeleteState> {
  DeleteTaskBloc() : super(InitialDeleteTaskState()) {
    on<DeleteButtonPressedForTaskEvent>((event, emit) async {
      emit(LoadingDeleteTaskState());
      try {
        final data = {
          'user_id' : '1',
          'db_connection': "erp_tata_steel_demo",
          'task_id': event.taskId.toString(),
        };

        final Uri url = Uri.parse("https://shiserp.com/demo/api/deleteTask");
        final response = await http.post(url, body: data);
        final Map<String, dynamic> decode = json.decode(response.body);

        if (response.statusCode == 200 && decode['status'] == 200) {
          emit(LoadedDeleteTaskState(message: decode['message']));
        } else {
          emit(FailureDeleteTaskState(error: decode['message'] ?? 'Delete failed'));
        }
      } catch (error) {
        emit(const FailureDeleteTaskState(error: "An error occurred"));
      }
    });
  }
}
