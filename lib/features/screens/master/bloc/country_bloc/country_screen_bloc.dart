import 'dart:convert';
import 'package:bloc_login/features/screens/master/bloc/country_bloc/country_screen_event.dart';
import 'package:bloc_login/features/screens/master/bloc/country_bloc/country_screen_state.dart';
import 'package:bloc_login/features/screens/master/model/country_model/country_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryInitial()) {
    on<FetchCountryEvent>(_fetchCountries);
  }

  Future<void> _fetchCountries(
      FetchCountryEvent event,
      Emitter<CountryState> emit,
      ) async {
    emit(CountryLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/countryList'),
      );

      final decode = json.decode(response.body);

      if (response.statusCode == 200 && decode['status'] == 200) {
        final model = CountryListModel.fromJsonMap(decode);
        emit(CountryLoaded(model.data));
      } else {
        emit(CountryFailure(decode['message'] ?? 'Failed to load country list'));
      }
    } catch (e) {
      emit(CountryFailure('Something went wrong'));
    }
  }
}
