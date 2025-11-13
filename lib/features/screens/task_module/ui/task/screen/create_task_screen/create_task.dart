import 'package:bloc_login/features/screens/task_module/ui/task/bloc/create_task/create_task_bloc.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/create_task/create_task_event.dart';
import 'package:bloc_login/features/screens/task_module/ui/task/bloc/create_task/create_task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return TaskCreateBloc();
      },
      child: const CreateTask(
        employeeId: '', userId: '1',
      ),
    );
  }
}

class CreateTask extends StatefulWidget {
  final String employeeId;

  const CreateTask({
    super.key,
    required this.employeeId, required String userId,
  });

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final taskNameController = TextEditingController();
  final taskDescController = TextEditingController();
  final remarkController = TextEditingController();
  final taskPriorityController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  final List<String> priorities = ['Low', 'Medium', 'High'];
  final Map<String, String> priorityMap = {
    'Low': '1',
    'Medium': '2',
    'High': '3',
  };

  Future<void> _selectDate(bool isStart) async {
    final DateTime today = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
      isStart ? (startDate ?? today) : (endDate ?? (startDate ?? today)),
      firstDate: isStart ? today : (startDate ?? today),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        final textVal = DateFormat('yyyy-MM-dd').format(picked);
        if (isStart) {
          startDate = picked;
          startDateController.text = textVal;
          if (endDate != null && endDate!.isBefore(picked)) {
            endDate = null;
            endDateController.clear();
          }
        } else {
          endDate = picked;
          endDateController.text = textVal;
        }
      });
    }
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescController.dispose();
    remarkController.dispose();
    taskPriorityController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    int maxLines = 1,
    VoidCallback? onTap,
    Widget? suffixIcon,
    Color? labelColor,
    String? hint,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: labelColor ?? Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xB0DFD9D5),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _onSave(BuildContext context) {
    final name = taskNameController.text;
    final desc = taskDescController.text;
    final remark = remarkController.text;
    final priority = taskPriorityController.text;
    final sDate = startDateController.text;
    final eDate = endDateController.text;

    if (name.isEmpty ||
        desc.isEmpty ||
        remark.isEmpty ||
        priority.isEmpty ||
        sDate.isEmpty ||
        eDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter data in all fields.'),
        ),
      );
      return;
    }
    BlocProvider.of<TaskCreateBloc>(context).add(
      TaskCreateRequested(
        taskName: name,
        description: desc,
        employeeId: widget.employeeId,
        startDate: sDate,
        endDate: eDate,
        taskPriority: priorityMap[priority] ?? '',
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            alignment: Alignment.center,
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
        titleSpacing: 0,
        title: const Text(
          "Create Task",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider<TaskCreateBloc>(
        create: (_) => TaskCreateBloc(),
        child: BlocListener<TaskCreateBloc, TaskCreateState>(
          listener: (context, state) {
            if (state is TaskCreateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
              Navigator.pop(context, true);
            }
            else if (state is TaskCreateFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildInputField(
                    label: "Task Name",
                    controller: taskNameController,
                    hint: "Enter task name",
                  ),
                  _buildInputField(
                    label: "Description",
                    controller: taskDescController,
                    maxLines: 4,
                    hint: "Enter description",
                  ),
                  _buildInputField(
                    label: "Remark",
                    controller: remarkController,
                    maxLines: 2,
                    hint: "Enter remark",
                  ),
                  DropdownButtonFormField<String>(
                    value: taskPriorityController.text.isEmpty
                        ? null
                        : taskPriorityController.text,
                    items: priorities.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: "Task Priority",
                      hintText: "Select priority",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xB0DFD9D5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        taskPriorityController.text = newValue ?? '';
                      });
                    },
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please select priority'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: "Start Date",
                    controller: startDateController,
                    readOnly: true,
                    onTap: () => _selectDate(true),
                    suffixIcon: const Icon(Icons.today),
                    labelColor: Colors.blue,
                    hint: "Select start date",
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: "End Date",
                    controller: endDateController,
                    readOnly: true,
                    onTap: () => _selectDate(false),
                    suffixIcon: const Icon(Icons.today),
                    hint: "Select end date",
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            side: const BorderSide(color: Colors.blue),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: BlocBuilder<TaskCreateBloc, TaskCreateState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is TaskCreateLoading
                                  ? null
                                  : () {
                                _onSave(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: state is TaskCreateLoading
                                  ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text('Creating...', style: TextStyle(color: Colors.white)),
                                ],
                              )
                                  : const Text('Save',
                                  style: TextStyle(color: Colors.white)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
