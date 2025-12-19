import 'dart:convert';
import 'package:bloc_login/features/screens/master/bloc/branch_bloc/branch_screen_event.dart';
import 'package:bloc_login/features/screens/master/bloc/branch_bloc/branch_screen_state.dart';
import 'package:bloc_login/features/screens/master/model/branch_model/branch_model_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<FetchBranchEvent>(_fetchBranches);
  }

  Future<void> _fetchBranches(
      FetchBranchEvent event,
      Emitter<BranchState> emit,
      ) async {
    emit(BranchLoading());

    try {
      final response = await http.post(
        Uri.parse('https://shiserp.com/demo/api/branchList'),
        body: {
          'user_id': '1',
          'db_connection': 'erp_tata_steel_demo',
        },
      );

      final jsonData = json.decode(response.body);

      if (response.statusCode == 200 && jsonData['status'] == 200) {
        final model = BranchListModel.fromJsonMap(jsonData);
        emit(BranchLoaded(model.data));
      } else {
        emit(BranchFailure(jsonData['message'] ?? 'Failed to load branches'));
      }
    } catch (e) {
      emit(BranchFailure('Something went wrong'));
    }
  }
}
