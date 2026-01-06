import 'package:bloc_login/features/screens/task_module/ui/task/bloc/create_task/create_task_bloc.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/create_task/create_task_event.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/create_task/create_task_state.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/screen/create_task_screen/employee_list_for_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCreateBloc(),
      child: const _CreateTaskView(),
    );
  }
}

class _CreateTaskView extends StatefulWidget {
  const _CreateTaskView();

  @override
  State<_CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<_CreateTaskView> {
  final taskNameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final remarkCtrl = TextEditingController();

  String? employeeId;
  String? employeeName;

  String priority = 'low';

  bool startToday = true;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  final Map<String, String> priorityMap = {
    'low': '1',
    'medium': '2',
    'high': '3',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        title: const Text(
          "Create Task",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
      ),

      body: BlocListener<TaskCreateBloc, TaskCreateState>(
        listener: (context, state) {
          if (state is TaskCreateSuccess) {
            _toast(state.message);
            Navigator.pop(context);
          } else if (state is TaskCreateFailure) {
            _toast(state.error);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _employeeSelector(),
              const SizedBox(height: 14),
              _taskNameField(),
              const SizedBox(height: 12),
              _descriptionField(),
              const SizedBox(height: 12),
              _priorityField(),
              const SizedBox(height: 12),
              _startDateField(),
              const SizedBox(height: 12),
              _endDateField(),
              const SizedBox(height: 12),
              _remarkField(),
              const SizedBox(height: 20),
              BlocBuilder<TaskCreateBloc, TaskCreateState>(
                builder: (context, state) {
                  final bool loading = state is TaskCreateLoading;
                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: loading
                              ? null
                              : () {
                                  Navigator.pop(context);
                                },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade400),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close,
                                size: 24,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: loading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: loading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Save',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _employeeSelector() {
    final bool hasEmployee = employeeId != null;
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EmployeeSelectScreen()),
        );

        if (result != null) {
          setState(() {
            employeeId = result['id'].toString();
            employeeName = result['name'];
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Employee Name',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasEmployee ? employeeName! : 'Select Employee',
                  style: TextStyle(
                    fontSize: 16,
                    color: hasEmployee ? Colors.black : Colors.grey,
                    fontWeight: hasEmployee ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldContainer({
    required String label,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  Widget _taskNameField() {
    return _fieldContainer(
      label: 'Task Name',
      child: TextField(
        controller: taskNameCtrl,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: 'Enter task name',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _descriptionField() {
    return _fieldContainer(
      label: 'Description',
      child: TextField(
        controller: descCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: 'Enter description',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _priorityField() {
    Color priorityColor(String value) {
      switch (value) {
        case 'low':
          return Colors.blue;
        case 'medium':
          return Colors.orange;
        case 'high':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }
    String priorityLabel(String value) {
      return value[0].toUpperCase() + value.substring(1);
    }

    return _fieldContainer(
      label: 'Task Priority',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: priority,
          isExpanded: true,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: ['low', 'medium', 'high'].map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Text(
                    priorityLabel(value),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: priorityColor(value),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (v) => setState(() => priority = v!),
        ),
      ),
    );
  }

  Widget _startDateField() {
    final bool isActive = startToday;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.calendar_today,
              size: 18,
              color: isActive ? Colors.blue : Colors.blue.shade200,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: isActive
                  ? () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                        initialDate: startDate,
                      );
                      if (picked != null) {
                        setState(() => startDate = picked);
                      }
                    }
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Starting Date',
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive ? Colors.blue : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    startDate.toString().split(' ')[0],
                    style: TextStyle(
                      fontSize: 16,
                      color: isActive ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                startToday = !startToday;
                if (startToday) {
                  startDate = DateTime.now();
                }
              });
            },
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isActive ? Colors.blue : Colors.grey.shade500,
                ),
              ),
              child: isActive
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _endDateField() {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          initialDate: endDate,
        );
        if (picked != null) {
          setState(() => endDate = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'End Date',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  endDate.toString().split(' ')[0],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.calendar_today,
                size: 18,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _remarkField() {
    return _fieldContainer(
      label: 'Remark for Employee',
      child: TextField(
        maxLines: 3,
        controller: remarkCtrl,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: 'Write Somethings....',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _submit() {
    if (employeeId == null) {
      _toast('Select employee');
      return;
    }

    context.read<TaskCreateBloc>().add(
          TaskCreateRequested(
            taskName: taskNameCtrl.text.trim(),
            description: descCtrl.text.trim(),
            employeeId: employeeId!,
            taskPriority: priorityMap[priority]!,
            startDate: startDate.toIso8601String(),
            endDate: endDate.toIso8601String(),
          ),
        );
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar
      (
        behavior: SnackBarBehavior.floating,
        content: Text(msg),),);
  }
}
