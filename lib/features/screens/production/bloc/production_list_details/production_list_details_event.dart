import 'package:equatable/equatable.dart';

abstract class ProductionDetailEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductionDetailEvent extends ProductionDetailEvents {
  final int orderId;

  FetchProductionDetailEvent({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId,];
}
