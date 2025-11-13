import 'package:bloc_login/features/screens/task_module/ui/task/screen/create_task_screen/create_task.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/delete_task/delete_task_bloc.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/delete_task/delete_task_event.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/task_list/task_list_bloc.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/task_list/task_list_event.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/task_list/task_list_state.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/screen/delete_task_bottom_sheet.dart';
import 'package:bloc_login/features/screens/task_module/ui/task_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required String userId});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => TaskBloc(),
  child: const TaskListScreenWidget(userId: "1", searchEmployee: '',),
);
  }
}


class TaskListScreenWidget extends StatefulWidget {
  final String userId;
  final String searchEmployee;
  const TaskListScreenWidget(
      {required this.userId, required this.searchEmployee, super.key});

  @override
  State<TaskListScreenWidget> createState() => _TaskListScreenWidgetState();
}

class _TaskListScreenWidgetState extends State<TaskListScreenWidget> {
  String? _downloadingUrl;
  final double _downloadProgress = 0.0;

  @override
  void initState() {
    BlocProvider.of<TaskBloc>(context).add(
      FetchTaskEvent(userId: widget.userId),
    );
    super.initState();
  }

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return '';
    }
  }

  final Map<String, Map<String, dynamic>> statusMap = {
    "1": {"label": "Pending", "color": Colors.orange},
    "2": {"label": "In Progress", "color": Colors.blue},
    "3": {"label": "Rejected", "color": Colors.red},
    "4": {"label": "Completed", "color": Colors.green},
    "5": {"label": "Re Open", "color": Colors.purple},
  };
  final Map<String, Map<String, dynamic>> priorityMap = {
    "1": {"label": "Low", "color": Colors.blue},
    "2": {"label": "Medium", "color": Colors.amber[700]},
    "3": {"label": "High", "color": Colors.red},
  };

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.inventory_outlined,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,),
                  ),
                  Text(
                    'Task Management',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          backgroundColor: Colors.blue,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                //
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateTask(userId: "1", employeeId: '',),),);
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  )),
            )
          ],
        ),
        body: Stack(
        children: [
          BlocBuilder<TaskBloc, TaskStates>(
            builder: (context, state) {
              if (state is LoadingTaskState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedTaskState) {
                final tasks = state.model.data;
                final filteredTasks = widget.searchEmployee.isEmpty
                    ? tasks
                    : tasks
                        .where((task) => (task.employeeName ?? '')
                            .toLowerCase()
                            .contains(widget.searchEmployee.toLowerCase()))
                        .toList();

                if (filteredTasks.isNotEmpty) {
                  return ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];

                      final statusInfo = statusMap[task.status] ??
                          {"label": "Unknown", "color": Colors.grey};
                      final String statusLabel = statusInfo["label"];
                      final Color statusColor = statusInfo["color"];

                      final priorityInfo = priorityMap[task.taskPriority] ??
                          {"label": "Unknown", "color": Colors.grey};
                      final String priorityLabel = priorityInfo["label"];
                      final Color priorityColor = priorityInfo["color"];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskDetails(task: task)),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3))
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(task.taskName,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange)),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        statusLabel,
                                        style: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      itemBuilder: (_) => [
                                        PopupMenuItem<String>(
                                          child: Row(children: [
                                            Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Icon(Icons.edit,
                                                    color: Colors.blue)),
                                            const SizedBox(width: 8),
                                            const Text('Edit'),
                                          ]),
                                        ),
                                        PopupMenuItem<String>(
                                          onTap: () {
                                            Future.delayed(Duration.zero, () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (_) =>
                                                    DeleteTaskBottomSheet(
                                                  task: task,
                                                  onDeleteConfirmed: () {
                                                    if (task.id == 0) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              "Task ID invalid"),
                                                        ),
                                                      );
                                                    } else {
                                                      BlocProvider.of<DeleteTaskBloc>(context).add(
                                                        DeleteButtonPressedForTaskEvent(
                                                            taskId: task.id,),
                                                      );
                                                    }
                                                  },
                                                ),
                                              );
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.red.withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('Delete'),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Icon(Icons.history,
                                                    color: Colors.blue),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('History'),
                                            ],
                                          ),
                                        ),
                                      ],
                                      icon: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.orange.shade100),
                                        ),
                                        child: const Icon(Icons.more_vert,
                                            color: Colors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.person_2_outlined),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Assigned to"),
                                      Text(
                                        task.employeeName ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: priorityColor.withOpacity(0.13),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      priorityLabel,
                                      style: TextStyle(
                                        color: priorityColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 170,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(16),
                                        border:
                                        Border.all(color: Colors.green.withOpacity(0.4)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.green.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: const Icon(Icons.arrow_right_outlined,
                                                    color: Colors.green),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('Start Date',
                                                  style: TextStyle(color: Colors.green)),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            formatDate(task.startDate),
                                            style: const TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(16),
                                        border:
                                        Border.all(color: Colors.orange.withOpacity(0.4)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: const Icon(Icons.flag_outlined,
                                                    color: Colors.orange),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('End Date',
                                                  style: TextStyle(color: Colors.orange)),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            formatDate(task.endDate),
                                            style: const TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.description_outlined,
                                          color: Colors.grey[600],
                                        ),
                                        const Text('Description')
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(task.description),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://cdni.iconscout.com/illustration/premium/thumb/no-data-found-illustration-download-in-svg-png-gif-file-formats--office-computer-digital-work-business-pack-illustrations-7265556.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const Text("Data Not Found!"),
                      ],
                    ),
                  );
                }
              } else if (state is FailureTaskState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              } else if (state is InternalServerErrorTaskState) {
                return Center(child: Text(state.error));
              } else if (state is ServerErrorTaskState) {
                return Center(child: Text(state.error));
              }
              return Container();
            },
          ),
          if (_downloadingUrl != null)
            Container(
              color: Colors.black45,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        'Downloading...  ${(100 * _downloadProgress).toStringAsFixed(1)}%',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
            ),
      );
  }
}
