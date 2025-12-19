import 'package:bloc_login/features/screens/hrmanager_module/ui/Salary_calculation/salary_calculation.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/weekoff_days/week_off_days.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
          "HR Settings",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manage Your HR configurations',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  SizedBox(height: 6),
                  Divider(
                    color: Colors.blue,
                    thickness: 4,
                    endIndent: 220,
                  ),
                ],
              ),
            ),

            _settingsTile(
              icon: Icons.calendar_today,
              iconColor: Colors.purple,
              bgColor: Colors.purple.withOpacity(0.2),
              title: 'Week-off Management',
              subtitle: 'Manage your week-off schedules',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WeekOffDays()),
                );
              },
            ),

            _settingsTile(
              icon: Icons.calculate,
              iconColor: Colors.green,
              bgColor: Colors.green.withOpacity(0.2),
              title: 'Salary Calculation',
              subtitle: 'Week offs are excluded',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SalaryCalculation()),
                );
              },
            ),

            _settingsTile(
              icon: Icons.location_on,
              iconColor: Colors.red,
              bgColor: Colors.red.withOpacity(0.2),
              title: 'Location Management',
              subtitle: 'Configure employee locations',
            ),

            _settingsTile(
              icon: Icons.access_time_outlined,
              iconColor: Colors.orange,
              bgColor: Colors.orange.withOpacity(0.2),
              title: 'Attendance Rules',
              subtitle: 'Attendance policies & regulations',
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Settings Tile
  Widget _settingsTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
      ),
    );
  }
}
