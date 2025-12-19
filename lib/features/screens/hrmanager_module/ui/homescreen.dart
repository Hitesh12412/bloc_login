import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final horizontalPadding = width * 0.04;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
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
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
          child: Column(
            children: [
              _buildBox(
                title: "Select Date",
                icon: Icons.date_range,
                color: Colors.blue,
                content: GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
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
                      ("5", "Pending Salary", Colors.orange),
                      ("18", "Total Employee", Colors.green),
                      ("15", "Present", Colors.teal),
                      ("1", "Absent", Colors.red),
                      ("0", "Half-Day", Colors.orange),
                      ("3", "Paid Leave", Colors.blue),
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
                      itemBuilder: (_, i) {
                        return _buildMetricTile(
                          data[i].$1,
                          data[i].$2,
                          data[i].$3,
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
                      height: height * 0.32,
                      child: SfCircularChart(
                        margin: EdgeInsets.zero,
                        annotations: const [
                          CircularChartAnnotation(
                            widget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Present: 85%", style: TextStyle(color: Colors.green, fontSize: 12)),
                                Text("Absent: 5.6%", style: TextStyle(color: Colors.red, fontSize: 12)),
                                Text("Half Day: 0%", style: TextStyle(color: Colors.orange, fontSize: 12)),
                                Text("Paid Leave: 15%", style: TextStyle(color: Colors.blue, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                        series: [
                          RadialBarSeries<_AttendanceData, String>(
                            maximumValue: 100,
                            innerRadius: '50%',
                            radius: '100%',
                            cornerStyle: CornerStyle.bothCurve,
                            gap: '6%',
                            dataSource: _attendanceData(),
                            xValueMapper: (d, _) => d.category,
                            yValueMapper: (d, _) => d.value,
                            pointColorMapper: (d, _) => d.color,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text("Graph is based on 23 working days", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildAttendanceFillUp(),
              const SizedBox(height: 16),
              _buildEmptyBox("Birthday Alert 🎉", Icons.cake, Colors.pink, "No Upcoming Birthdays", "No birthdays to celebrate this month"),
              const SizedBox(height: 16),
              _buildEmptyBox("Upcoming Leave 🗓️", Icons.event_available, Colors.orange, "No Leave Found", "No upcoming leaves scheduled"),
              const SizedBox(height: 16),
              _buildBox(title: "Attendance Fill Up", icon: Icons.fingerprint, color: Colors.purple, content: const Text("Empty")),
              const SizedBox(height: 16),
              _buildBox(title: "Yesterday Attendance", icon: Icons.history, color: Colors.amber, content: const Text("No data")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBarIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, size: 26, color: Colors.black),
    );
  }

  List<_AttendanceData> _attendanceData() {
    return [
      _AttendanceData("Present", 85, Colors.green),
      _AttendanceData("Absent", 5.6, Colors.red),
      _AttendanceData("Half Day", 0, Colors.orange),
      _AttendanceData("Paid Leave", 15, Colors.blue),
    ];
  }

  Widget _buildMetricTile(String value, String label, Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 160;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(value, style: TextStyle(fontSize: isSmall ? 18 : 22, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  CircleAvatar(
                    radius: isSmall ? 18 : 22,
                    backgroundColor: color.withOpacity(0.2),
                    child: Icon(Icons.more_horiz, color: color),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(label, maxLines: 2, overflow: TextOverflow.ellipsis),
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
              gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
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

  Widget _buildEmptyBox(String title, IconData icon, Color color, String main, String sub) {
    return _buildBox(
      title: title,
      icon: icon,
      color: color,
      content: Column(
        children: [
          Icon(icon, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text(main, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildAttendanceFillUp() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF00A86B), Color(0xFF28C76F)]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Row(
              children: [
                Icon(Icons.pie_chart, color: Colors.white),
                SizedBox(width: 8),
                Text("Attendance Fill-up Methods 📊", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: SfCircularChart(
                      margin: EdgeInsets.zero,
                      series: [
                        DoughnutSeries<_FillUpData, String>(
                          dataSource: [
                            _FillUpData('Lens App', 1, Colors.blue),
                            _FillUpData('HR Entry', 0, Colors.green),
                            _FillUpData('Web', 0, Colors.purple),
                          ],
                          xValueMapper: (d, _) => d.method,
                          yValueMapper: (d, _) => d.count,
                          pointColorMapper: (d, _) => d.color,
                          innerRadius: '70%',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Entries: 1", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("Lens App 1 (100%)"),
                      Text("HR Entry 0 (0%)"),
                      Text("Web 0 (0%)"),
                    ],
                  ),
                ),
              ],
            ),
          ),
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

class _FillUpData {
  final String method;
  final int count;
  final Color color;

  _FillUpData(this.method, this.count, this.color);
}
