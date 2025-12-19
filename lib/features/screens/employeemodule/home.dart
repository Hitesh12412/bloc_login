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
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.dashboard_rounded, size: 34, color: Colors.white),
        ),
        centerTitle: true,
        title: const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg",
          ),
        ),
        actions: [
          _appBarIcon(Icons.notifications),
          const SizedBox(width: 10),
          _appBarIcon(Icons.person_2_rounded),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 12,
          ),
          child: Column(
            children: [
              
              _buildBox(
                title: "Select Date",
                icon: Icons.date_range,
                color: Colors.blue.shade800,
                content: GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down),
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
                content: LayoutBuilder(
                  builder: (context, constraints) {
                    final isTablet = constraints.maxWidth > 600;

                    final data = [
                      ("5", "Pending Salary", Colors.orange, Icons.pending_actions),
                      ("18", "Total Employee", Colors.green, Icons.groups),
                      ("15", "Present", Colors.teal, Icons.check_circle),
                      ("1", "Absent", Colors.red, Icons.cancel),
                      ("0", "Half-Day", Colors.orange, Icons.timelapse),
                      ("3", "Paid Leave", Colors.blue, Icons.wallet),
                    ];

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 3 : 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: isTablet ? 1.8 : 1.4,
                      ),
                      itemBuilder: (context, index) {
                        return _buildMetricTile(
                          data[index].$1,
                          data[index].$2,
                          data[index].$3,
                          data[index].$4,
                        );
                      },
                    );
                  },
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
                      height: screenHeight * 0.32,
                      child: SfCircularChart(
                        margin: EdgeInsets.zero,
                        annotations: const [
                          CircularChartAnnotation(
                            widget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Present: 85%", style: TextStyle(color: Colors.green)),
                                Text("Absent: 5.6%", style: TextStyle(color: Colors.red)),
                                Text("Half Day: 0%", style: TextStyle(color: Colors.orange)),
                                Text("Paid Leave: 15%", style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ],
                        series: <RadialBarSeries<_AttendanceData, String>>[
                          RadialBarSeries<_AttendanceData, String>(
                            maximumValue: 100,
                            gap: '6%',
                            radius: '100%',
                            innerRadius: '50%',
                            cornerStyle: CornerStyle.bothCurve,
                            dataSource: _getAttendanceData(),
                            xValueMapper: (data, _) => data.category,
                            yValueMapper: (data, _) => data.value,
                            pointColorMapper: (data, _) => data.color,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Graph is based on 23 working days",
                      style: TextStyle(fontWeight: FontWeight.w600),
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

  
  Widget _appBarIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 26, color: Colors.black),
    );
  }

  
  Widget _buildMetricTile(
      String value,
      String label,
      Color color,
      IconData icon,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 160;

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
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: isSmall ? 18 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: isSmall ? 18 : 22,
                    backgroundColor: color.withOpacity(0.2),
                    child: Icon(icon, color: color, size: isSmall ? 20 : 26),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isSmall ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  
  Widget _buildBox({
    required String title,
    required IconData icon,
    required Color color,
    required Widget content,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
        ],
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
}

class _AttendanceData {
  final String category;
  final double value;
  final Color color;

  _AttendanceData(this.category, this.value, this.color);
}
