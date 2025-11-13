import 'package:bloc_login/features/screens/production/model/details_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductionDetailStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialProductionDetailState extends ProductionDetailStates {}

class LoadingProductionDetailState extends ProductionDetailStates {}

class LoadedProductionDetailState extends ProductionDetailStates {
  final ProductionDetailModel model;

  LoadedProductionDetailState({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}

class FailureProductionDetailState extends ProductionDetailStates {
  final String error;

  FailureProductionDetailState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class InternalServerErrorProductionDetailState extends ProductionDetailStates {
  final String error;

  InternalServerErrorProductionDetailState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ServerErrorProductionDetailState extends ProductionDetailStates {
  final String error;

  ServerErrorProductionDetailState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
