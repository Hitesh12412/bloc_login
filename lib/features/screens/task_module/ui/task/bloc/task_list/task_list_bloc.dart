import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/task_list/task_list_event.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/task_list/task_list_state.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/model/task_list_model/task_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class TaskBloc extends Bloc<TaskEvents, TaskStates> {
  TaskBloc() : super(InitialTaskState()) {
    on<FetchTaskEvent>((event, emit) async {
      emit(LoadingTaskState());
      try {
        TaskListModel model = await fetchTaskList(
          userID: event.userId,
        );
        if (model.status == 200) {
          emit(LoadedTaskState(model: model));
        }
        else {
          emit(FailureTaskState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorTaskState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorTaskState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureTaskState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<TaskListModel> fetchTaskList({
    required userID,
  }) async {
    final data = {
      'user_id': userID,
      'db_connection': "erp_tata_steel_demo",
      'search_text': ''
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/taskList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return TaskListModel.fromJsonMap(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
