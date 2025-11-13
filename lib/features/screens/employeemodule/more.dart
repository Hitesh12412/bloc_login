import 'package:bloc_login/features/screens/employeemodule/account_screen.dart';
import 'package:bloc_login/features/screens/employeemodule/extra_fund.dart';
import 'package:bloc_login/features/screens/employeemodule/festival_holiday/screen/holiday.dart';
import 'package:bloc_login/features/screens/employeemodule/leave_application.dart';
import 'package:bloc_login/features/screens/employeemodule/ride/screen/ride.dart';
import 'package:bloc_login/features/screens/employeemodule/salary_structure.dart';
import 'package:flutter/material.dart';

class EmployeeMore extends StatefulWidget {
  const EmployeeMore({super.key});

  @override
  State<EmployeeMore> createState() => _EmployeeMoreState();
}

class _EmployeeMoreState extends State<EmployeeMore> {
  @override
  Widget build(BuildContext context) {


    Color getIconColor(String moduleName) {
      switch (moduleName) {
        case 'Account':
          return Colors.blue;
        case 'Leave Application':
          return Colors.purple;
        case 'Extra Fund':
          return Colors.orange;
        case 'Salary Structure':
          return Colors.green;
        case 'Ride':
          return Colors.red;
        case 'Festival Holiday':
          return Colors.teal;
        default:
          return Colors.blueAccent;
      }
    }

    IconData getFallbackIcon(String moduleName) {
      switch (moduleName) {
        case 'Account':
          return Icons.person;
        case 'Leave Application':
          return Icons.groups;
        case 'Extra Fund':
          return Icons.task;
        case 'Salary Structure':
          return Icons.support_agent_rounded;
        case 'Ride':
          return Icons.shopping_cart;
        case 'Festival Holiday':
          return Icons.shopping_bag;
        default:
          return Icons.dashboard;
      }
    }


    final List<Widget> moduleScreens = [
      const AccountScreen(),
      const LeaveApplication(),
      const ExtraFund(),
      const SalaryStructure(),
      const Ride(),
      const Holiday(),
    ];
    final List<String> moduleNames = [
      'Account',
      'Leave Application',
      'Extra Fund',
      'Salary Structure',
      'Ride',
      'Festival Holiday'
    ];
    final List<String> moduleIconPaths = [
      'assets/icons/account.png',
      'assets/icons/leave.png',
      'assets/icons/fund.png',
      'assets/icons/salary.png',
      'assets/icons/ride.png',
      'assets/icons/holiday.png',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),),
        automaticallyImplyLeading: false,
        title: const Text(
          "Employee More",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: moduleNames.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
              childAspectRatio: 1
          ),
          itemBuilder: (context, index) {
            final moduleName = moduleNames[index];
            final iconColor = getIconColor(moduleName);
            return GestureDetector(
              onTap: () {
                _navigateToModule(
                    context, moduleName, moduleScreens[index]);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        moduleIconPaths[index],
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            getFallbackIcon(moduleName),
                            size: 35,
                            color: iconColor,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      moduleName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToModule(
      BuildContext context, String moduleName, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
