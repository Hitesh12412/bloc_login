import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TaskHome extends StatefulWidget {
  const TaskHome({super.key});

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  DateTime _startDate = DateTime(2025, 7, 1);
  DateTime _endDate = DateTime(2025, 7, 7);

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _endDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(Icons.dashboard_rounded,
                size: 32, color: Colors.white),
          ),
        ),
        centerTitle: true,
        title: const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg",
          ),
        ),
        actions: [
          _appBarIcon(Icons.notifications),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _appBarIcon(Icons.person_2_rounded),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              /// DATE FILTER
              Container(
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    _gradientHeader(Icons.calendar_today, "Filter by Date Range"),
                    Row(
                      children: [
                        Expanded(child: _dateBox(_startDate, _pickStartDate)),
                        const SizedBox(width: 6),
                        _arrowCircle(),
                        const SizedBox(width: 6),
                        Expanded(child: _dateBox(_endDate, _pickEndDate)),
                      ],
                    ),
                    _confirmCircle(),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// EMPLOYEE DASHBOARD
              _buildBox(
                title: "Employee Dashboard",
                icon: Icons.people,
                color: Colors.teal,
                content: GridView.count(
                  crossAxisCount: screenWidth < 360 ? 1 : 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  children: [
                    _buildMetricTile("5", "Pending Salary", Colors.orange,
                        Icons.pending_actions),
                    _buildMetricTile("18", "Total Employee", Colors.green,
                        Icons.people),
                    _buildMetricTile(
                        "15", "Present", Colors.teal, Icons.check_circle),
                    _buildMetricTile(
                        "1", "Absent", Colors.red, Icons.cancel),
                    _buildMetricTile(
                        "0", "Half-Day", Colors.orange, Icons.timelapse),
                    _buildMetricTile(
                        "3", "Paid Leave", Colors.blue, Icons.event_available),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ATTENDANCE OVERVIEW
              _buildBox(
                title: "Attendance Overview",
                icon: Icons.pie_chart,
                color: Colors.blue,
                content: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.32,
                      child: SfCircularChart(
                        margin: EdgeInsets.zero,
                        annotations: const [
                          CircularChartAnnotation(
                            widget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Present: 85.0%",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 12)),
                                Text("Absent: 5.6%",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)),
                                Text("Half Day: 0.0%",
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 12)),
                                Text("Paid Leave: 15.0%",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                        series: <RadialBarSeries<_AttendanceData, String>>[
                          RadialBarSeries<_AttendanceData, String>(
                            maximumValue: 100,
                            gap: '5%',
                            cornerStyle: CornerStyle.bothCurve,
                            radius: '100%',
                            innerRadius: '50%',
                            dataSource: _getAttendanceData(),
                            xValueMapper: (d, _) => d.category,
                            yValueMapper: (d, _) => d.value,
                            pointColorMapper: (d, _) => d.color,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Graph is based on 23 working days.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- HELPERS ----------------

  Widget _appBarIcon(IconData icon) => Container(
    padding: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, size: 26, color: Colors.black),
  );

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 2))
    ],
  );

  Widget _gradientHeader(IconData icon, String title) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16)),
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.blue.withOpacity(0.7)],
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 10),
        Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  List<_AttendanceData> _getAttendanceData() => [
    _AttendanceData("Present", 85, Colors.green),
    _AttendanceData("Absent", 5.6, Colors.red),
    _AttendanceData("Half Day", 0, Colors.orange),
    _AttendanceData("Paid Leave", 15, Colors.blue),
  ];

  Widget _buildMetricTile(
      String value, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBox({
    required String title,
    required IconData icon,
    required Color color,
    required Widget content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              gradient:
              LinearGradient(colors: [color, color.withOpacity(0.7)]),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(16), child: content),
        ],
      ),
    );
  }
}

/// ---------------- OUTSIDE WIDGETS ----------------

Widget _dateBox(DateTime date, VoidCallback onTap) => InkWell(
  onTap: onTap,
  child: Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_today_rounded,
            size: 20, color: Colors.blue),
        const SizedBox(width: 10),
        Text(DateFormat('dd/MM/yyyy').format(date)),
      ],
    ),
  ),
);

Widget _arrowCircle() => Container(
  padding: const EdgeInsets.all(6),
  decoration: BoxDecoration(
    color: Colors.blue.withOpacity(0.2),
    borderRadius: BorderRadius.circular(8),
  ),
  child: const Icon(Icons.compare_arrows, color: Colors.blue),
);

Widget _confirmCircle() => Container(
  margin: const EdgeInsets.all(10),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.filter_alt_outlined, color: Colors.white),
      SizedBox(width: 6),
      Text('Apply Filter',
          style: TextStyle(color: Colors.white, fontSize: 16)),
    ],
  ),
);

class _AttendanceData {
  final String category;
  final double value;
  final Color color;

  _AttendanceData(this.category, this.value, this.color);
}
