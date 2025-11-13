import 'package:bloc_login/features/screens/employeemodule/salary_structure.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee_location.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/hr_report.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/leave_management.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/setting.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> hrOptions = [
      {
        'name': 'Settings',
        'icon': Icons.settings,
        'color': Colors.blueAccent,
        'onTap': () { Navigator.push(context, MaterialPageRoute(builder: (context)=> const Setting())); },
      },
      {
        'name': 'Reports',
        'icon': Icons.analytics,
        'color': Colors.green,
        'onTap': () { Navigator.push(context, MaterialPageRoute(builder: (context)=> const HrReport()));  },
      },
      {
        'name': 'Salary Structure',
        'icon': Icons.account_balance_wallet,
        'color': Colors.orange,
        'onTap': () { Navigator.push(context, MaterialPageRoute(builder: (context)=> const SalaryStructure()));  },
      },
      {
        'name': 'Leave Application',
        'icon': Icons.calendar_today,
        'color': Colors.purple,
        'onTap': () { Navigator.push(context, MaterialPageRoute(builder: (context)=> const LeaveManagement())); },
      },
      {
        'name': 'Employee Location',
        'icon': Icons.location_on,
        'color': Colors.red,
        'onTap': () { Navigator.push(context, MaterialPageRoute(builder: (context)=> const EmployeeLocation()));},
      },
    ];

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
                child: const Icon(Icons.person_3_rounded,color: Colors.blue,)),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Human resources',style: TextStyle(fontSize: 13,color: Colors.white),)
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: hrOptions.length,
          itemBuilder: (context, index) {
            return _buildHROptionButton(
              context: context,
              name: hrOptions[index]['name'],
              icon: hrOptions[index]['icon'],
              color: hrOptions[index]['color'],
              onTap: hrOptions[index]['onTap'],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHROptionButton({
    required BuildContext context,
    required String name,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
