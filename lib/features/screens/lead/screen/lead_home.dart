import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeadHome extends StatefulWidget {
  const LeadHome({super.key});

  @override
  State<LeadHome> createState() => _LeadHomeState();
}

class _LeadHomeState extends State<LeadHome> {
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.blue.withOpacity(0.7)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Filter by Date Range",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _dateBox(_startDate, _pickStartDate),
                        ),
                        const SizedBox(width: 8),
                        _arrowCircle(),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _dateBox(_endDate, _pickEndDate),
                        ),
                      ],
                    ),
                    _confirmCircle(),
                  ],
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
Widget _dateBox(DateTime date, VoidCallback onTap) => InkWell(
  onTap: onTap,
  child: Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey),
      boxShadow: const [
        BoxShadow(
            color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today_rounded,
            size: 20,
            color: Colors.blue,
          ),
          const SizedBox(width: 15),
          Text(
            "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  ),
);

Widget _arrowCircle() => Container(
  padding: const EdgeInsets.all(6),
  decoration: BoxDecoration(
    color: Colors.blue.withOpacity(0.2),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
    ],
  ),
  child: const Icon(Icons.compare_arrows, color: Colors.blue),
);

Widget _confirmCircle() => Container(
  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
    ],
  ),
  child: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.filter_alt_outlined, color: Colors.white),
      SizedBox(width: 6),
      Text(
        'Apply Filter',
        style: TextStyle(color: Colors.white, fontSize: 16),
      )
    ],
  ),
);

class _AttendanceData {
  final String category;
  final double value;
  final Color color;

  _AttendanceData(this.category, this.value, this.color);
}
