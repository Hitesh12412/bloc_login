import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/employee_data.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/create_employee_bloc/create_employee_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/model/employee_model.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/repo/create_employee_repository.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/screen/create_employee_screen/create_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  bool _scrollListenerAdded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(FetchEmployees());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_scrollListenerAdded) {
      _scrollController.addListener(_onScroll);
      _scrollListenerAdded = true;
    }
  }

  void _onScroll() {
    final bloc = context.read<EmployeeBloc>();
    final state = bloc.state;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (state is EmployeeLoaded && !state.hasReachedMax) {
        bloc.add(FetchMoreEmployees());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color _statusColor(int status) {
    switch (status) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.green;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.person_2_outlined, color: Colors.blue),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employee',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Manage your team',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                )
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.help_outline, color: Colors.blue),
            ),
          )
        ],
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeError) {
            return Center(child: Text(state.message));
          }

          if (state is EmployeeLoaded) {
            final employees = _searchQuery.isEmpty
                ? state.employees
                : state.employees
                .where((e) =>
                e.name.toLowerCase().contains(_searchQuery.toLowerCase()))
                .toList();

            return Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                children: [
                  _pendingSalary(state.pendingSalary),
                  const SizedBox(height: 12),
                  _addEmployee(state.employees.length),
                  const SizedBox(height: 14),
                  _search(),
                  const SizedBox(height: 14),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<EmployeeBloc>().add(FetchEmployees());
                      },
                      child: employees.isEmpty
                          ? _empty()
                          : ListView.builder(
                        controller: _scrollController,
                        itemCount: employees.length +
                            (state.hasReachedMax ? 0 : 1),
                        itemBuilder: (context, index) {
                          if (index >= employees.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                  child: CircularProgressIndicator()),
                            );
                          }

                          final e = employees[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EmployeeData(employee: e),
                                ),
                              );
                            },
                            child: Card(
                              margin:
                              const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 26,
                                          backgroundImage:
                                          e.employeeProfile.isNotEmpty
                                              ? NetworkImage(
                                              "https://shiserp.com/demo/${e.employeeProfile}")
                                              : null,
                                          child: e.employeeProfile.isEmpty
                                              ? const Icon(Icons.person)
                                              : null,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color:
                                              _statusColor(e.status),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.name,
                                            maxLines: 1,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '+91 ${e.mobileNo}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '₹${e.salary}',
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4),
                                          decoration: BoxDecoration(
                                            color:
                                            Colors.green.shade50,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            e.categoryName,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.green),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _pendingSalary(double value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet, color: Colors.red, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Pending Salary',
                    style: TextStyle(color: Colors.grey)),
                Text('₹${value.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _search() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by name',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (v) => setState(() => _searchQuery = v),
    );
  }

  Widget _addEmployee(int count) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) =>
                  CreateEmployeeBloc(CreateEmployeeRepository()),
              child: const CreateEmployeeScreen(),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.person_add, color: Colors.white),
            const SizedBox(width: 10),
            const Text('Add New Employee',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const Spacer(),
            Text('$count/100',
                style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _empty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_alt, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text('No employees found', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
