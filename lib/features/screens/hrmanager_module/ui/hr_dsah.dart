import 'package:bloc_login/features/screens/hrmanager_module/ui/attendance_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/screen/employee_list/EmployeeScreen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/employee_lis_bloc/employeebloc_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/homescreen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/more_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/salary_screen.dart';
import 'package:bloc_login/services/employee_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HrDash extends StatefulWidget {
  const HrDash({super.key});

  @override
  State<HrDash> createState() => _HrDashState();
}

class _HrDashState extends State<HrDash> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(key: PageStorageKey('home')),

    BlocProvider(
      create: (_) => EmployeeBloc(employeeService: EmployeeService())..add(FetchEmployees()),
      child: const EmployeeScreen(key: PageStorageKey('employee')),
    ),

    const AttendanceScreen(key: PageStorageKey('attendance')),

    BlocProvider(
      create: (_) => EmployeeBloc(employeeService: EmployeeService())..add(FetchEmployees()),
      child: const SalaryScreen(key: PageStorageKey('salary')),
    ),

    const MoreScreen(key: PageStorageKey('more')),
  ];

  final List<IconData> _iconData = const [
    Icons.home,
    Icons.person_2_outlined,
    Icons.checklist_sharp,
    Icons.credit_card,
    Icons.person_2_rounded,
  ];

  final List<String> _labels = const [
    'Home',
    'Employee',
    'Attendance',
    'Salary',
    'More',
  ];

  List<Widget> get _navItems {
    return List.generate(_iconData.length, (index) {
      final isActive = _currentIndex == index;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _iconData[index],
                color: Colors.white,
                size: isActive ? 24.0 : 24.0,
              ),
            ),
            if (!isActive) ...[
              Text(
                _labels[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 55.0,
        color: Colors.black,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.blue,
        items: _navItems,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
