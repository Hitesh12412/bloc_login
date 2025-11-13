import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<String> months = List.generate(
    12,
        (index) => DateFormat.MMMM().format(DateTime(0, index + 1)),
  );

  int selectedMonthIndex = DateTime.now().month - 1;
  late String selectedMonth;
  List<DateTime> daysInMonth = [];
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedMonth = months[selectedMonthIndex];
    generateDaysInMonth();
  }

  void generateDaysInMonth() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, selectedMonthIndex + 1, 1);
    final daysCount =
    DateUtils.getDaysInMonth(now.year, selectedMonthIndex + 1);

    daysInMonth = List.generate(
      daysCount,
          (index) => firstDayOfMonth.add(Duration(days: index)),
    );

    if (selectedDayIndex >= daysInMonth.length) {
      selectedDayIndex = 0;
    }
  }

  void showMonthSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.drag_handle, color: Colors.grey),
              const SizedBox(height: 8),
              const Text(
                'Select Month',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 1, height: 24),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedMonthIndex;
                    return ListTile(
                      title: Text(
                        months[index],
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: Colors.blue)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedMonthIndex = index;
                          selectedMonth = months[selectedMonthIndex];
                          generateDaysInMonth();
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(height: 1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                child: const Icon(Icons.calendar_today,color: Colors.blue,)),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attendance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('View and manage attendance',style: TextStyle(fontSize: 13,color: Colors.white),)
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: showMonthSelector,
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.today, color: Colors.blue),
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                selectedMonth,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daysInMonth.length,
                itemBuilder: (context, index) {
                  final date = daysInMonth[index];
                  final isSelected = index == selectedDayIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            DateFormat.E().format(date),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.bar_chart, color: Colors.blueAccent),
                        SizedBox(width: 15),
                        Text(
                          "Attendance Overview",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      runSpacing: 20,
                      spacing: 24,
                      children: [
                        _attendanceBox("Present", "0"),
                        _attendanceBox("Absent", "0"),
                        _attendanceBox("Half Day", "0"),
                        _attendanceBox("Paid Leave", "0"),
                        _attendanceBox("Overtime", "0:00 hrs"),
                        _attendanceBox("Fine", "0:00 hrs"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Employee',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    ["M", "N", "P", "A"][index],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      [
                                        "Milan Patel",
                                        "Narendra Chauhan",
                                        "Parth Shah",
                                        "Arjun Roy"
                                      ][index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        "ABSENT",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: PopupMenuButton<int>(
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (index) {
                                    if (index == 0) {
                                    } else if (index == 1) {
                                    } else if (index == 2) {
                                    } else if (index == 3) {
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 0,
                                      child: Row(
                                        children: [
                                          Icon(Icons.co_present, color: Colors.green),
                                          SizedBox(width: 5),
                                          Text('Present'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Icon(Icons.close, color: Colors.red),
                                          SizedBox(width: 5),
                                          Text('Absent'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Row(
                                        children: [
                                          Icon(Icons.access_time, color: Colors.orange),
                                          SizedBox(width: 5),
                                          Text('Half Day'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 3,
                                      child: Row(
                                        children: [
                                          Icon(Icons.flight_takeoff, color: Colors.blue),
                                          SizedBox(width: 5),
                                          Text('Leave'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50.withOpacity(0.4),
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close,
                                          size: 14, color: Colors.white),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "Employee was absent",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _attendanceBox(String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
