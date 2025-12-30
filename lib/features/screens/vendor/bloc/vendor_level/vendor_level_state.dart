import 'package:bloc_login/features/screens/vendor/model/vendor_level_model.dart';
import 'package:equatable/equatable.dart';

abstract class VendorLevelState extends Equatable {
  const VendorLevelState();

  @override
  List<Object?> get props => [];
}

class VendorLevelInitial extends VendorLevelState {}

class VendorLevelLoading extends VendorLevelState {}

class VendorLevelLoaded extends VendorLevelState {
  final List<VendorLevelModel> levels;

  const VendorLevelLoaded(this.levels);

  @override
  List<Object?> get props => [levels];
}

class VendorLevelFailure extends VendorLevelState {
  final String message;

  const VendorLevelFailure(this.message);

  @override
  List<Object?> get props => [message];
}
