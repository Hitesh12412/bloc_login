
import 'package:bloc_login/features/screens/master/model/city_model/city_screen.dart';

abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<CityData> cities;

  CityLoaded(this.cities);
}

class CityFailure extends CityState {
  final String error;

  CityFailure(this.error);
}
