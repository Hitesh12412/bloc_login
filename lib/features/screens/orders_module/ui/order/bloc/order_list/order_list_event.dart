import 'package:equatable/equatable.dart';

abstract class OrderEvents extends Equatable {
  const OrderEvents();

  @override
  List<Object?> get props => [];
}

class FetchOrderEvent extends OrderEvents {
  final String userId;
  final String? searchText;

  const FetchOrderEvent({
    required this.userId,
    this.searchText,
  });

  @override
  List<Object?> get props => [userId, searchText];
}
