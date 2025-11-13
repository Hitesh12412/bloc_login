import 'package:bloc_login/features/screens/dispatch/model/dispatch_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class DispatchListStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialDispatchListState extends DispatchListStates {}

class LoadingDispatchListState extends DispatchListStates {}

class LoadedDispatchListState extends DispatchListStates {
  final DispatchList model;

  LoadedDispatchListState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureDispatchListState extends DispatchListStates {
  final String error;

  FailureDispatchListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorDispatchListState extends DispatchListStates {
  final String error;

  InternalServerErrorDispatchListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorDispatchListState extends DispatchListStates {
  final String error;

  ServerErrorDispatchListState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
