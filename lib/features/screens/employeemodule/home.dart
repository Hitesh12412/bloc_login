import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({super.key});

  @override
  State<EmployeeHome> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.dashboard_rounded, size: 36, color: Colors.white),
        ),
        centerTitle: true,
        title: const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg?semt=ais_hybrid&w=740",
          ),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.notifications, size: 28, color: Colors.black)),
          const SizedBox(width: 10),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.person_2_rounded,
              size: 28,
              color: Colors.black,
            ),)
        ],
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildBox(
                title: "Select Date",
                icon: Icons.date_range,
                color: Colors.blue.shade800,
                content: GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('dd MMM yyyy').format(selectedDate),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildBox(
                title: "Employee Dashboard",
                icon: Icons.people,
                color: Colors.teal,
                content: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMetricTile("5", "Pending Salary", Colors.orange, Icons.pending_actions),
                    _buildMetricTile("18", "Total Employee", Colors.green, Icons.message),
                    _buildMetricTile("15", "Present", Colors.teal, Icons.add_box_sharp),
                    _buildMetricTile("1", "Absent", Colors.red, Icons.pending_actions),
                    _buildMetricTile("0", "Half-Day", Colors.orange, Icons.add_box_sharp),
                    _buildMetricTile("3", "Paid Leave", Colors.blue, Icons.message),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              _buildBox(
                title: "Attendance Overview",
                icon: Icons.pie_chart,
                color: Colors.blue,
                content: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: SfCircularChart(
                        margin: EdgeInsets.zero,
                        annotations: const [
                          CircularChartAnnotation(
                            widget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Present: 85.0%", style: TextStyle(color: Colors.green, fontSize: 12),),
                                Text("Absent: 5.6%", style: TextStyle(color: Colors.red, fontSize: 12),),
                                Text("Half Day: 0.0%", style: TextStyle(color: Colors.orange, fontSize: 12),),
                                Text("Paid Leave: 15.0%", style: TextStyle(color: Colors.blue, fontSize: 12),),
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
                            xValueMapper: (data, _) => data.category,
                            yValueMapper: (data, _) => data.value,
                            pointColorMapper: (data, _) => data.color,
                            dataLabelSettings: const DataLabelSettings(isVisible: false),
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
              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }

  List<_AttendanceData> _getAttendanceData() {
    return [
      _AttendanceData("Present", 85, Colors.green),
      _AttendanceData("Absent", 5.6, Colors.red),
      _AttendanceData("Half Day", 0, Colors.orange),
      _AttendanceData("Paid Leave", 15, Colors.blue),
    ];
  }

  Widget _buildMetricTile(String value, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: color.withOpacity(0.2),
                  child: Icon(icon, size: 25, color: color),
                ),
              ],
            ),
          ),
          Text(label, style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
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
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              gradient: LinearGradient(colors: [color, color.withOpacity(0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(16), child: content),
        ],
      ),
    );
  }
}

class _AttendanceData {
  final String category;
  final double value;
  final Color color;

  _AttendanceData(this.category, this.value, this.color);
}
