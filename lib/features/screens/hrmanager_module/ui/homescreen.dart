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
      backgroundColor: const Color(0xFFF5F7FA),
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
                color: Colors.blue,
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
                    _buildMetricTile("5", "Pending Salary", Colors.orange),
                    _buildMetricTile("18", "Total Employee", Colors.green),
                    _buildMetricTile("15", "Present", Colors.teal),
                    _buildMetricTile("1", "Absent", Colors.red),
                    _buildMetricTile("0", "Half-Day", Colors.orange),
                    _buildMetricTile("3", "Paid Leave", Colors.blue),
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
                        annotations: const <CircularChartAnnotation>[
                          CircularChartAnnotation(
                            widget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Present: 85.0%", style: TextStyle(color: Colors.green, fontSize: 12)),
                                Text("Absent: 5.6%", style: TextStyle(color: Colors.red, fontSize: 12)),
                                Text("Half Day: 0.0%", style: TextStyle(color: Colors.orange, fontSize: 12)),
                                Text("Paid Leave: 15.0%", style: TextStyle(color: Colors.blue, fontSize: 12)),
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

              buildAttendanceFillUp(),
              const SizedBox(height: 16),

              _buildBox(
                title: "Birthday Alert 🎉",
                icon: Icons.cake,
                color: Colors.pink,
                content: const Column(
                  children: [
                    Icon(Icons.cake, size: 48, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      "No Upcoming Birthdays",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "No birthdays to celebrate this month",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              _buildBox(
                title: "Upcoming Leave 🗓️",
                icon: Icons.event_available,
                color: Colors.orange,
                content: const Column(
                  children: [
                    Icon(Icons.event_busy, size: 48, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      "No Leave Found",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "No upcoming leaves scheduled at the moment.",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              _buildBox(
                title: "Attendance Fill Up",
                icon: Icons.fingerprint,
                color: Colors.purple,
                content: const Text("Empty", style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),

              _buildBox(
                title: "Yesterday Attendance",
                icon: Icons.history,
                color: Colors.amber,
                content: const Text("No data", style: TextStyle(fontSize: 16)),
              ),
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

  Widget _buildMetricTile(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(label, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          CircleAvatar(
            radius: 14,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(Icons.more_horiz, size: 16, color: color),
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

  Widget buildAttendanceFillUp() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              gradient: LinearGradient(colors: [Color(0xFF00A86B), Color(0xFF28C76F)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            padding: const EdgeInsets.all(12),
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
            child: Column(
              children: [
                // pie chart + legend
                Row(
                  children: [
                    Expanded(
                      flex: 4,
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
                              xValueMapper: (data, _) => data.method,
                              yValueMapper: (data, _) => data.count,
                              pointColorMapper: (data, _) => data.color,
                              innerRadius: '70%',
                              dataLabelSettings: const DataLabelSettings(isVisible: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Entries: 1", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Row(children: [
                              Icon(Icons.camera_alt, color: Colors.blue, size: 16),
                              SizedBox(width: 4),
                              Text("Lens App 1 (100%)", style: TextStyle(fontSize: 12)),
                            ]),
                            SizedBox(height: 4),
                            Row(children: [
                              Icon(Icons.person, color: Colors.green, size: 16),
                              SizedBox(width: 4),
                              Text("HR Entry 0 (0%)", style: TextStyle(fontSize: 12)),
                            ]),
                            SizedBox(height: 4),
                            Row(children: [
                              Icon(Icons.web, color: Colors.purple, size: 16),
                              SizedBox(width: 4),
                              Text("Web 0 (0%)", style: TextStyle(fontSize: 12)),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(12),
                  child: const Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("Most Used", style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("Lens App 1 (100%)", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Align(alignment: Alignment.centerLeft, child: Text("Attendance Status", style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    minHeight: 12,
                    value: 1.0,
                    backgroundColor: Colors.green.shade100,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, size: 10, color: Colors.green),
                        SizedBox(width: 4),
                        Text("On Time: 0 (0%)", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 10, color: Colors.red),
                        SizedBox(width: 4),
                        Text("Late: 1 (100%)", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.green.shade50, border: Border.all(color: Colors.green.shade200), borderRadius: BorderRadius.circular(8)),
                        child: const Column(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(height: 8),
                            Text("On Time", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("0 entries", style: TextStyle(fontSize: 12)),
                            Text("0%", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.red.shade50, border: Border.all(color: Colors.red.shade200), borderRadius: BorderRadius.circular(8)),
                        child: const Column(
                          children: [
                            Icon(Icons.access_time, color: Colors.red),
                            SizedBox(height: 8),
                            Text("Late Entry", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("1 entries", style: TextStyle(fontSize: 12)),
                            Text("100%", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
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
