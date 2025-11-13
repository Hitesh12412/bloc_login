import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/employee_data.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/create_employee_bloc/create_employee_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/model/employee_model.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_event.dart';
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

  Color _statusDotColor(int status) {
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Icon(Icons.person_2_outlined,color: Colors.blue,),),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employee',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Manage your team',style: TextStyle(fontSize: 13,color: Colors.white),)
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: (){
                //
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.help_outline, color: Colors.blue),
              )
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
            List<Employee> employees = state.employees;
            final pendingSalary = state.pendingSalary;

            final filteredEmployees = _searchQuery.isNotEmpty
                ? employees
                    .where((e) => e.name
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                    .toList()
                : employees;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildPendingSalaryCard(pendingSalary),
                  const SizedBox(height: 12),
                  _buildAddEmployeeButton(employees.length),
                  const SizedBox(height: 16),
                  _buildSearchField(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<EmployeeBloc>().add(FetchEmployees());
                      },
                      child: filteredEmployees.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              controller: _scrollController,
                              key: const PageStorageKey('employeeList'),
                              padding: const EdgeInsets.only(bottom: 6),
                              itemCount: filteredEmployees.length +
                                  (state.hasReachedMax ? 0 : 1),
                              itemBuilder: (context, index) {
                                if (index >= filteredEmployees.length) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                                final employee = filteredEmployees[index];
                                return Dismissible(
                                  key: ValueKey(employee.id),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (_) async {
                                    return await showModalBottomSheet<bool>(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(16))),
                                        builder: (context) => Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Icons.warning,
                                                      size: 48,
                                                      color: Colors.red),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    "Delete ${employee.name}?",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  const Text(
                                                    "This action cannot be undone.",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .shade300,
                                                            foregroundColor:
                                                                Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, false);
                                                          },
                                                          child: const Text(
                                                              "Cancel"),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, true);
                                                          },
                                                          child: const Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ));
                                  },
                                  background: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      color: Colors.red.shade400,
                                      child: const Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              EmployeeData(employee: employee),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 2,
                                      margin: const EdgeInsets.only(bottom: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            Stack(
                                              children: [
                                                CircleAvatar(
                                                  radius: 28,
                                                  backgroundImage: employee
                                                          .employeeProfile
                                                          .isNotEmpty
                                                      ? NetworkImage(
                                                          "https://shiserp.com/demo/${employee.employeeProfile}")
                                                      : null,
                                                  child: employee
                                                          .employeeProfile
                                                          .isEmpty
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
                                                      color: _statusDotColor(
                                                          employee.status),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue
                                                                    .shade200)),
                                                        child: Text(
                                                            "#${employee.id}",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        12)),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        employee.name,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue
                                                                    .shade200)),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.phone,
                                                              color:
                                                                  Colors.blue,
                                                              size: 12,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              '+91 ${employee.mobileNo}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    "₹${employee.salary}",
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors
                                                            .green.shade200),
                                                  ),
                                                  child: Text(
                                                    employee.categoryName,
                                                    style: const TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
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
          return const Center(child: Text('No data'));
        },
      ),
    );
  }

  Widget _buildPendingSalaryCard(double pendingSalary) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                color: Colors.red,
                size: 32,
              )),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Pending Salary: ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '₹${pendingSalary.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by name...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        setState(() => _searchQuery = value);
      },
    );
  }

  Widget _buildAddEmployeeButton(int currentCount) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider<CreateEmployeeBloc>(
                      create: (_) => CreateEmployeeBloc(CreateEmployeeRepository()),
                      child: const CreateEmployeeScreen(),
                    )));
          },
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Add New Employee',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$currentCount/100',
                    style: const TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ));
  }

  Widget _buildEmptyState() {
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
