import 'package:bloc_login/features/screens/master/model/country_model/country_model.dart';


abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final List<CountryData> countries;

  CountryLoaded(this.countries);
}

class CountryFailure extends CountryState {
  final String error;

  CountryFailure(this.error);
}
