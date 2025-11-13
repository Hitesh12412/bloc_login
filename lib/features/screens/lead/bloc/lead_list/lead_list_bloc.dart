import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/lead/bloc/lead_list/lead_list_event.dart';
import 'package:bloc_login/features/screens/lead/bloc/lead_list/lead_list_state.dart';
import 'package:bloc_login/features/screens/lead/model/lead_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class LeadListBloc extends Bloc<LeadListEvents, LeadListStates> {
  LeadListBloc() : super(InitialLeadListState()) {
    on<FetchLeadListEvent>((event, emit) async {
      emit(LoadingLeadListState());

      try {
        LeadList model = await fetchLeadListList(
          dbConnection: 'erp_tata_steel_demo',
          leadCategoryId: event.leadCategoryId ?? '0',
          pageNumber: event.pageNumber ?? '1',
          pageSize: '10',
          userId: '1',
          status: event.status ?? '',
        );
        if (model.status == 200) {
          emit(LoadedLeadListState(model: model));
        } else {
          emit(FailureLeadListState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorLeadListState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorLeadListState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureLeadListState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<LeadList> fetchLeadListList({
    required String dbConnection,
    required String leadCategoryId,
    required String pageNumber,
    required String pageSize,
    required String userId,
    required String status,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'lead_category_id': leadCategoryId,
      'page_number': pageNumber,
      'page_size': pageSize,
      'user_id': userId,
      'status': status,
    };
    final Uri url = Uri.parse("https://shiserp.com/demo/api/leadList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return LeadList.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
