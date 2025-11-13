import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/employee_data.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final String _searchQuery = '';
  bool _scrollListenerAdded = false;

  Color _statusDotColor(int status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
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
                child: const Icon(Icons.money,color: Colors.blue,)),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Monthly pay Details',style: TextStyle(fontSize: 13,color: Colors.white),)
              ],
            ),
          ],
        ),
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

            final filteredEmployees = _searchQuery.isNotEmpty
                ? employees
                .where((e) => e.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
                .toList()
                : employees;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: filteredEmployees.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                      controller: _scrollController,
                      key: const PageStorageKey('employeeList'),
                      padding: const EdgeInsets.only(bottom: 10),
                      itemCount: filteredEmployees.length +
                          (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index >= filteredEmployees.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.blue,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                                )),
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
                                    borderRadius:
                                    BorderRadius.vertical(
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
                                                Colors
                                                    .grey.shade300,
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
                              margin:
                              const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(16),
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
                                                decoration:
                                                BoxDecoration(
                                                    color: Colors
                                                        .blue
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
                                                    style: const TextStyle(
                                                        color:
                                                        Colors.blue,
                                                        fontSize: 12)),
                                              ),
                                              const SizedBox(
                                                  width: 8),
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
                                                decoration:
                                                BoxDecoration(
                                                    color: Colors
                                                        .blue
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
                ],
              ),
            );
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network('https://cdni.iconscout.com/illustration/premium/thumb/no-data-found-illustration-download-in-svg-png-gif-file-formats--office-computer-digital-work-business-pack-illustrations-7265556.png',height: 100,
            width: 100,
            fit: BoxFit.cover,),
          const Text("Data Not Found!"),
        ],
      ),
    );
  }
}
