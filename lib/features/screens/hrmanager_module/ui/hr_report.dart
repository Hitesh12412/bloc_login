import 'package:flutter/material.dart';

class HrReport extends StatefulWidget {
  const HrReport({super.key});

  @override
  State<HrReport> createState() => _HrReportState();
}

class _HrReportState extends State<HrReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios,
                color: Colors.white, size: 20),
          ),
        ),
        title: const Text(
          "HR Report",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          _headerCard(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _reportTile(
                    icon: Icons.calendar_today,
                    iconColor: Colors.purple,
                    bgColor: Colors.purple.withOpacity(0.2),
                    title: 'Week-off Management',
                    subtitle: 'Manage your week-off schedules',
                  ),
                  _reportTile(
                    icon: Icons.calculate,
                    iconColor: Colors.green,
                    bgColor: Colors.green.withOpacity(0.2),
                    title: 'Salary Calculation',
                    subtitle: 'Week offs are excluded',
                  ),
                  _reportTile(
                    icon: Icons.location_on,
                    iconColor: Colors.red,
                    bgColor: Colors.red.withOpacity(0.2),
                    title: 'Location Management',
                    subtitle: 'Configure location for employee',
                  ),
                  _reportTile(
                    icon: Icons.access_time_outlined,
                    iconColor: Colors.orange,
                    bgColor: Colors.orange.withOpacity(0.2),
                    title: 'Attendance Rules',
                    subtitle: 'Attendance policies and regulations',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.insert_chart_rounded,
                size: 28, color: Colors.white),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Analytics Dashboard',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Access comprehensive HR reports',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'and insights',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reportTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style:
                  const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}
