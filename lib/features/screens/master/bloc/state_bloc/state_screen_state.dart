
import 'package:bloc_login/features/screens/master/model/state_model/state_model.dart';

abstract class StateState {}

class StateInitial extends StateState {}

class StateLoading extends StateState {}

class StateLoaded extends StateState {
  final List<StateData> states;

  StateLoaded(this.states);
}

class StateFailure extends StateState {
  final String error;

  StateFailure(this.error);
}
