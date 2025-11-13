import 'package:bloc/bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/repo/create_employee_repository.dart';
import 'create_employee_event.dart';
import 'create_employee_state.dart';

class CreateEmployeeBloc extends Bloc<CreateEmployeeEvent, CreateEmployeeState> {
  final CreateEmployeeRepository repository;

  CreateEmployeeBloc(this.repository) : super(CreateEmployeeInitial()) {
    on<SubmitCreateEmployeeEvent>((event, emit) async {
      emit(CreateEmployeeLoading());
      try {
        final success = await repository.createEmployee(
          name: event.name,
          designation: event.designation,
          dateOfBirth: event.dateOfBirth,
          dateOfJoining: event.dateOfJoining,
          email: event.email,
          mobileNo: event.mobileNo,
          employeeCode: event.employeeCode,
          profilePicture: event.profilePicture,
        );
        if (success) {
          emit(CreateEmployeeSuccess());
        } else {
          emit(CreateEmployeeFailure('Failed to create employee'));
        }
      } catch (e) {
        emit(CreateEmployeeFailure(e.toString()));
      }
    });
  }
}
