import 'package:equatable/equatable.dart';

abstract class VendorLevelEvent extends Equatable {
  const VendorLevelEvent();

  @override
  List<Object?> get props => [];
}

class FetchVendorLevels extends VendorLevelEvent {
  final String dbConnection;

  const FetchVendorLevels({required this.dbConnection});

  @override
  List<Object?> get props => [dbConnection];
}
