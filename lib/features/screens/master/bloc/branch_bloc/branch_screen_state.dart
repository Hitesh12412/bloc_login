import 'package:bloc_login/features/screens/master/model/branch_model/branch_model_class.dart';

abstract class BranchState {}

class BranchInitial extends BranchState {}

class BranchLoading extends BranchState {}

class BranchLoaded extends BranchState {
  final List<BranchData> branches;

  BranchLoaded(this.branches);
}

class BranchFailure extends BranchState {
  final String error;

  BranchFailure(this.error);
}
