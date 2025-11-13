import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/dispatch/bloc/dispatch_list_event.dart';
import 'package:bloc_login/features/screens/dispatch/bloc/dispatch_list_state.dart';
import 'package:bloc_login/features/screens/dispatch/model/dispatch_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class DispatchListBloc extends Bloc<DispatchListEvents, DispatchListStates> {
  DispatchListBloc() : super(InitialDispatchListState()) {
    on<FetchDispatchListEvent>((event, emit) async {
      emit(LoadingDispatchListState());

      try {
        DispatchList model = await fetchDispatchListList(
          dbConnection: 'erp_tata_steel_demo',
          DispatchCategoryId: event.DispatchCategoryId ?? '0',
          pageNumber: event.pageNumber ?? '1',
          pageSize: '10',
          userId: '1',
          status: event.status ?? '',
        );
        if (model.status == 200) {
          emit(LoadedDispatchListState(model: model));
        } else {
          emit(FailureDispatchListState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorDispatchListState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorDispatchListState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureDispatchListState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<DispatchList> fetchDispatchListList({
    required String dbConnection,
    required String DispatchCategoryId,
    required String pageNumber,
    required String pageSize,
    required String userId,
    required String status,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'Dispatch_category_id': DispatchCategoryId,
      'page_number': pageNumber,
      'page_size': pageSize,
      'user_id': userId,
      'status': status,
    };
    final Uri url = Uri.parse("https://shiserp.com/demo/api/getDispatchList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return DispatchList.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
