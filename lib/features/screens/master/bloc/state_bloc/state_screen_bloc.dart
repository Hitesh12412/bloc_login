import 'dart:convert';
import 'package:bloc_login/features/screens/master/bloc/state_bloc/state_screen_event.dart';
import 'package:bloc_login/features/screens/master/bloc/state_bloc/state_screen_state.dart';
import 'package:bloc_login/features/screens/master/model/state_model/state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class StateBloc extends Bloc<StateEvent, StateState> {
  StateBloc() : super(StateInitial()) {
    on<FetchStateEvent>(_fetchStateList);
  }

  Future<void> _fetchStateList(
      FetchStateEvent event,
      Emitter<StateState> emit,
      ) async {
    emit(StateLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/stateList'),
        body: {
          'country_id': event.countryId.toString(),
        },
      );

      final decode = json.decode(response.body);

      if (response.statusCode == 200 && decode['status'] == 200) {
        final model = StateListModel.fromJsonMap(decode);
        emit(StateLoaded(model.data));
      } else {
        emit(StateFailure(decode['message'] ?? 'Failed to load states'));
      }
    } catch (_) {
      emit(StateFailure('Something went wrong'));
    }
  }
}
