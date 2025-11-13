import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/support/bloc/support_details_bloc/support_details_event.dart';
import 'package:bloc_login/features/screens/support/model/support_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'support_details_state.dart';

class SupportDetailBloc extends Bloc<SupportDetailEvents, SupportDetailStates> {
  SupportDetailBloc() : super(InitialSupportDetailState()) {
    on<FetchSupportDetailEvent>((event, emit) async {
      emit(LoadingSupportDetailState());

      try {
        SupportResponse model = await fetchSupportDetail(
          dbConnection: 'erp_tata_steel_demo',
          supportId: event.supportId,
          userId: '2',
        );
        if (model.status == 200) {
          emit(LoadedSupportDetailState(model: model));
        } else {
          emit(FailureSupportDetailState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorSupportDetailState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorSupportDetailState(error: "HTTP error occurred: ${e.message}"));
        }
      } catch (error) {
        emit(FailureSupportDetailState(error: "An error occurred: $error"));
      }
    });
  }

  Future<SupportResponse> fetchSupportDetail({
    required String dbConnection,
    required int supportId,
    required String userId,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'support_id': supportId.toString(),
      'user_id': userId,
    };

    final Uri url = Uri.parse("https://shiserp.com/demo/api/listSupport");

    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        return SupportResponse.fromJson(json.decode(response.body));
      } else {
        throw HttpException('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Error: $e');
    }
  }
}
