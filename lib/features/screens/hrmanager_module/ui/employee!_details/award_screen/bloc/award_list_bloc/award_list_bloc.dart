import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/award_screen/bloc/award_list_bloc/award_list_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/award_screen/bloc/award_list_bloc/award_list_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/award_screen/model/award_list_model/award_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class AwardBloc extends Bloc<AwardEvents, AwardStates> {
  AwardBloc() : super(InitialAwardState()) {
    on<FetchAwardEvent>((event, emit) async {
      emit(LoadingAwardState());
      try {
        AwardListModel model = await fetchAwardList(
          employeeId: event.employeeId,
        );

        if (model.status == 200) {
          emit(LoadedAwardState(model: model));
        }
        else {
          emit(FailureAwardState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorAwardState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorAwardState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureAwardState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<AwardListModel> fetchAwardList({
    required String employeeId,
  }) async {
    final data = {
      'employee_id': employeeId,
      'db_connection': "erp_tata_steel_demo",
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/getAwardList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return AwardListModel.fromJsonMap(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
