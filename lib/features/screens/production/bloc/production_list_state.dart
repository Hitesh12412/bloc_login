
import 'package:bloc_login/features/screens/production/model/production_model.dart';

abstract class ProductionListStates {}

class InitialProductionListState extends ProductionListStates {}

class LoadingProductionListState extends ProductionListStates {}

class LoadedProductionListState extends ProductionListStates {
  final ProductionResponse model;

  LoadedProductionListState({required this.model});
}

class FailureProductionListState extends ProductionListStates {
  final String error;

  FailureProductionListState({required this.error});
}

class InternalServerErrorProductionListState extends ProductionListStates {
  final String error;

  InternalServerErrorProductionListState({required this.error});
}

class ServerErrorProductionListState extends ProductionListStates {
  final String error;

  ServerErrorProductionListState({required this.error});
}
