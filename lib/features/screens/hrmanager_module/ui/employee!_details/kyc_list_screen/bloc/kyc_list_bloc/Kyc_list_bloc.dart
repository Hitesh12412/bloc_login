import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/bloc/kyc_list_bloc/Kyc_list_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/bloc/kyc_list_bloc/Kyc_list_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/model/kyc_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class KycBloc extends Bloc<KycEvents, KycStates> {
  KycBloc() : super(InitialKycState()) {
    on<FetchKycEvent>((event, emit) async {
      emit(LoadingKycState());
      try {
        KycListModel model = await fetchKycList(
          employeeId: event.employeeId,
        );

        if (model.status == 200) {
          emit(LoadedKycState(model: model));
        }
        else {
          emit(FailureKycState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorKycState(error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorKycState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureKycState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<KycListModel> fetchKycList({
    required String employeeId,
  }) async {
    final data = {
      'employee_id': employeeId,
      'db_connection': "erp_tata_steel_demo",
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/getKycList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return KycListModel.fromJsonMap(json.decode(response.body));
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
