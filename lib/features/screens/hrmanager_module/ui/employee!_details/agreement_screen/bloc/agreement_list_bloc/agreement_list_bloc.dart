import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/bloc/agreement_list_bloc/agreement_list_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/bloc/agreement_list_bloc/agreement_list_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/model/agreement_list_model/agreement_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class AgreementBloc extends Bloc<AgreementEvents, AgreementStates> {
  AgreementBloc() : super(InitialAgreementState()) {
    on<FetchAgreementEvent>((event, emit) async {
      emit(LoadingAgreementState());
      try {
        AgreementListModel model = await fetchAgreementList(
          employeeId: event.employeeId,
        );

        if (model.status == 200) {
          emit(LoadedAgreementState(model: model));
        }
        else {
          emit(FailureAgreementState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorAgreementState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorAgreementState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureAgreementState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<AgreementListModel> fetchAgreementList({
    required String employeeId,
  }) async {
    final data = {
      'employee_id': employeeId,
      'db_connection': "erp_tata_steel_demo",
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/getAgreementList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return AgreementListModel.fromJsonMap(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
