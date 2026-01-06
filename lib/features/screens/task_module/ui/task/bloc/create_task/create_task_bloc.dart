import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'create_task_event.dart';
import 'create_task_state.dart';

class TaskCreateBloc extends Bloc<TaskCreateEvent, TaskCreateState> {
  TaskCreateBloc() : super(TaskCreateInitial()) {
    on<TaskCreateRequested>((event, emit) async {
      emit(TaskCreateLoading());

      try {
        final Map<String, String> data = {
          'user_id': '1',
          'db_connection': 'erp_tata_steel_demo',
          'name': event.taskName,
          'description': event.description,
          'employee_id': event.employeeId,
          'task_priority': event.taskPriority,
          'start_date': event.startDate,
          'end_date': event.endDate,
        };

        if (kDebugMode) {
          print('🚀 CreateTask POST BODY 👉 $data');
        }

        final response = await http.post(
          Uri.parse("https://shiserp.com/demo/api/createTask"),
          body: data,
        );

        final decode = json.decode(response.body);

        if (kDebugMode) {
          print('✅ CreateTask RESPONSE 👉 $decode');
        }

        if (response.statusCode == 200 && decode['status'] == 200) {
          emit(TaskCreateSuccess(
            decode['message'] ?? "Task created successfully",
          ));
        } else {
          emit(TaskCreateFailure(
            decode['message'] ?? "Failed to create task",
          ));
        }
      } catch (e) {
        emit(TaskCreateFailure("Something went wrong: $e"));
      }
    });
  }
}


