import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/support/bloc/support_screen_event.dart';
import 'package:bloc_login/features/screens/support/bloc/support_screen_state.dart';
import 'package:bloc_login/features/screens/support/model/support_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SupportListBloc extends Bloc<SupportListEvents, SupportListStates> {
  SupportListBloc() : super(InitialSupportListState()) {
    on<FetchSupportListEvent>((event, emit) async {
      emit(LoadingSupportListState());

      try {
        SupportResponse model = await fetchSupportListList(
          dbConnection: 'erp_tata_steel_demo',
          supportCategoryId: event.supportCategoryId ?? '0',
          pageNumber: event.pageNumber ?? '1',
          pageSize: '10',
          userId: '1',
          status: event.status ?? '',
          searchText: event.searchText,
        );
        if (model.status == 200) {
          emit(LoadedSupportListState(model: model));
        } else {
          emit(FailureSupportListState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorSupportListState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorSupportListState(error: "HTTP error occurred: ${e.message}"));
        }
      } catch (error) {
        emit(FailureSupportListState(error: "An error occurred: $error"));
      }
    });
  }

  Future<SupportResponse> fetchSupportListList({
    required String dbConnection,
    required String supportCategoryId,
    required String pageNumber,
    required String pageSize,
    required String userId,
    required String status,
    String? searchText,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'Support_category_id': supportCategoryId,
      'page_number': pageNumber,
      'page_size': pageSize,
      'user_id': userId,
      'status': status,
      'search_text': searchText ?? '',
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
