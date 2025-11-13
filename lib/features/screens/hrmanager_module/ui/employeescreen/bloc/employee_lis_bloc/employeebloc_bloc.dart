import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/model/employee_model.dart';
import 'package:bloc_login/services/employee_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'employeebloc_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeService employeeService;
  int _currentPage = 1;
  final int _pageSize = 8;
  bool _hasReachedMax = false;
  bool _isFetching = false;
  final List<Employee> _employees = [];
  double _pendingSalary = 0.0;

  EmployeeBloc({required this.employeeService}) : super(EmployeeInitial()) {
    on<FetchEmployees>(_onFetchEmployees);
    on<FetchMoreEmployees>(_onFetchMoreEmployees);
  }

  Future<void> _onFetchEmployees(
      FetchEmployees event,
      Emitter<EmployeeState> emit,
      ) async {
    if (_isFetching) return;
    emit(EmployeeLoading());
    _isFetching = true;

    try {
      _currentPage = 1;
      _hasReachedMax = false;
      _employees.clear();

      final result = await employeeService.getEmployees(
        page: _currentPage,
        pageSize: _pageSize,
      );
      final newEmployees = result['employees'] as List<Employee>;
      _pendingSalary = result['pendingSalary'] as double? ?? 0.0;

      _employees.addAll(newEmployees);
      _hasReachedMax = newEmployees.length < _pageSize;

      emit(EmployeeLoaded(
        List<Employee>.from(_employees),
        hasReachedMax: _hasReachedMax,
        pendingSalary: _pendingSalary,
      ));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onFetchMoreEmployees(
      FetchMoreEmployees event,
      Emitter<EmployeeState> emit,
      ) async {
    if (_isFetching || _hasReachedMax || state is EmployeeLoading) return;
    _isFetching = true;

    try {
      _currentPage++;

      final result = await employeeService.getEmployees(
        page: _currentPage,
        pageSize: _pageSize,
      );
      final newEmployees = result['employees'] as List<Employee>;

      if (newEmployees.isEmpty || newEmployees.length < _pageSize) {
        _hasReachedMax = true;
      }

      _employees.addAll(newEmployees);

      emit(EmployeeLoaded(
        List<Employee>.from(_employees),
        hasReachedMax: _hasReachedMax,
        pendingSalary: _pendingSalary,
      ));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}
