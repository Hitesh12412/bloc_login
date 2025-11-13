import 'package:bloc_login/features/screens/task_module/ui/task/model/task_list_model/task_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';

class TaskDetails extends StatefulWidget {
  final TaskData task;

  const TaskDetails({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  static const statusMap = {
    "1": {"label": "Pending", "color": Colors.orange},
    "2": {"label": "In Progress", "color": Colors.blue},
    "3": {"label": "Rejected", "color": Colors.red},
    "4": {"label": "Completed", "color": Colors.green},
    "5": {"label": "Re Open", "color": Colors.purple},
  };
  static final priorityMap = {
    "1": {"label": "Low", "color": Colors.blue},
    "2": {"label": "Medium", "color": Colors.amber[700]}, // yellow
    "3": {"label": "High", "color": Colors.red},
  };

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final statusInfo =
        statusMap[task.status] ?? {"label": "Unknown", "color": Colors.grey};
    final String statusLabel = statusInfo["label"] as String;
    final Color statusColor = statusInfo["color"] as Color;

    final priorityInfo = priorityMap[task.taskPriority] ??
        {"label": "Unknown", "color": Colors.grey};
    final String priorityLabel = priorityInfo["label"] as String;
    final Color priorityColor = priorityInfo["color"] as Color;

    return Scaffold(
      appBar: AppBar(
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
          "Task Details",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.edit, color: Colors.blue.shade900, size: 24)),
          )
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          task.taskName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 18),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.27),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: statusColor.withOpacity(0.34)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                statusLabel,
                                style: TextStyle(
                                    color: statusColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.person_2_outlined,
                              color: Colors.blueAccent,
                            )),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Assigned to',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              task.employeeName ?? "-",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: priorityColor.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(16),
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
                      ],
                    ),
                  ),
                  Row(
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
                                const Text(
                                  'End Date',
                                  style: TextStyle(color: Colors.orange),
                                ),
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
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.contact_page_outlined,
                                  color: Colors.purple),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (task.description).isEmpty
                              ? "No description"
                              : task.description,
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const ExpandableCommentBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableCommentBox extends StatefulWidget {
  const ExpandableCommentBox({super.key});

  @override
  State<ExpandableCommentBox> createState() => _ExpandableCommentBoxState();
}

class _ExpandableCommentBoxState extends State<ExpandableCommentBox> {
  bool _isExpanded = false;
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _comments = [];

  void _addComment() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(
        () {
          _comments.add(
            {
              'text': text,
              'timestamp': DateTime.now(),
            },
          );
          _controller.clear();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                const Text(
                  'Comments',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(
                height: 10,
              ),
              if (_comments.isEmpty)
                const Text("No comments yet.",
                    style: TextStyle(color: Colors.grey)),
              ..._comments.map(
                (comment) {
                  final text = comment['text'];
                  final timestamp = comment['timestamp'] as DateTime;
                  final timeAgo = GetTimeAgo.parse(timestamp);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• ",
                            style: TextStyle(fontSize: 16, height: 1.4)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    text,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    timeAgo,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Type your comment...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _addComment,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
