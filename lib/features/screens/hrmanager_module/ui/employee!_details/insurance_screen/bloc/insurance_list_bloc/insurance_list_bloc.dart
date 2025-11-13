import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/insurance_screen/bloc/insurance_list_bloc/insurance_list_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/insurance_screen/bloc/insurance_list_bloc/insurance_list_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/insurance_screen/model/insurance_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class InsuranceBloc extends Bloc<InsuranceEvents, InsuranceStates> {
  InsuranceBloc() : super(InitialInsuranceState()) {
    on<FetchInsuranceEvent>((event, emit) async {
      emit(LoadingInsuranceState());
      try {
        InsuranceListModel model = await fetchInsuranceList(
          employeeId: event.employeeId,
        );

        if (model.status == 200) {
          emit(LoadedInsuranceState(model: model));
        }
        else {
          emit(FailureInsuranceState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorInsuranceState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorInsuranceState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureInsuranceState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<InsuranceListModel> fetchInsuranceList({
    required String employeeId,
  }) async {
    final data = {
      'employee_id': employeeId,
      'db_connection': "erp_tata_steel_demo",
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/getInsuranceList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return InsuranceListModel.fromJsonMap(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
