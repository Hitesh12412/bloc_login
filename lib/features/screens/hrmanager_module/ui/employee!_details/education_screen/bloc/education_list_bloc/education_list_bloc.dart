import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/education_screen/bloc/education_list_bloc/education_list_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/education_screen/bloc/education_list_bloc/education_list_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/education_screen/model/education_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class EducationBloc extends Bloc<EducationEvents, EducationStates> {
  EducationBloc() : super(InitialEducationState()) {
    on<FetchEducationEvent>((event, emit) async {
      emit(LoadingEducationState());
      try {
        EducationListModel model = await fetchEducationList(
          employeeId: event.employeeId,
        );

        if (model.status == 200) {
          emit(LoadedEducationState(model: model));
        }
        else {
          emit(FailureEducationState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorEducationState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorEducationState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureEducationState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<EducationListModel> fetchEducationList({
    required String employeeId,
  }) async {
    final data = {
      'employee_id': employeeId,
      'db_connection': "erp_tata_steel_demo",
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/getEducationList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return EducationListModel.fromJsonMap(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
