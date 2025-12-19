import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'client_list_event.dart';
import 'client_list_state.dart';
import '../../model/client_list/client_list_model_class.dart';

class ClientBloc extends Bloc<ClientEvents, ClientStates> {
  ClientBloc() : super(InitialClientState()) {
    on<FetchClientEvent>(_onFetchClient);
  }

  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoadingMore = false;
  final List<ClientData> _clients = [];

  Future<void> _onFetchClient(
      FetchClientEvent event,
      Emitter<ClientStates> emit,
      ) async {
    if (event.isLoadMore && (!_hasNextPage || _isLoadingMore)) return;

    if (event.isLoadMore) {
      _isLoadingMore = true;
      emit(LoadingMoreClientState());
    } else {
      _currentPage = 1;
      _hasNextPage = true;
      _clients.clear();
      emit(LoadingClientState());
    }

    try {
      final model = await fetchClientList(
        userID: event.userId,
        searchText: event.searchText,
        page: _currentPage,
      );

      if (model.status == 200) {
        _clients.addAll(model.data);
        _hasNextPage = model.hasNextPage;
        _currentPage++;

        emit(
          LoadedClientState(
            model: model,
            clients: List<ClientData>.from(_clients),
            hasNextPage: _hasNextPage,
          ),
        );
      } else {
        emit(FailureClientState(error: model.message));
      }
    } on SocketException {
      emit(FailureClientState(error: "No internet connection"));
    } on HttpException catch (e) {
      emit(FailureClientState(error: e.message));
    } catch (_) {
      emit(FailureClientState(error: "Something went wrong"));
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<ClientListModel> fetchClientList({
    required String userID,
    String? searchText,
    required int page,
  }) async {
    final Map<String, String> body = {
      'user_id': '1',
      'db_connection': "erp_tata_steel_demo",
      'search_text': searchText ?? '',
      'page': page.toString(),
    };

    final Uri url =
    Uri.parse("https://shiserp.com/demo/api/confirmClientList");

    final response = await http
        .post(url, body: body)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return ClientListModel.fromJsonMap(json.decode(response.body));
    } else if (response.statusCode == 500) {
      throw const HttpException("Internal Server Error (500)");
    } else {
      throw HttpException("Server Error (${response.statusCode})");
    }
  }
}
