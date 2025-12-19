import 'dart:convert';
import 'package:bloc_login/features/screens/master/bloc/city_bloc/city_screen_event.dart';
import 'package:bloc_login/features/screens/master/bloc/city_bloc/city_screen_state.dart';
import 'package:bloc_login/features/screens/master/model/city_model/city_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial()) {
    on<FetchCityEvent>(_fetchCityList);
  }

  Future<void> _fetchCityList(
      FetchCityEvent event,
      Emitter<CityState> emit,
      ) async {
    emit(CityLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/cityList'),
        body: {
          'state_id': event.stateId.toString(),
        },
      );

      final decode = json.decode(response.body);

      if (response.statusCode == 200 && decode['status'] == 200) {
        final model = CityListModel.fromJsonMap(decode);
        emit(CityLoaded(model.data));
      } else {
        emit(CityFailure(decode['message'] ?? 'Failed to load cities'));
      }
    } catch (_) {
      emit(CityFailure('Something went wrong'));
    }
  }
}
