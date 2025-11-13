import 'package:bloc_login/features/screens/lead/screen/calls.dart';
import 'package:bloc_login/features/screens/lead/screen/lead.dart';
import 'package:bloc_login/features/screens/lead/screen/lead_home.dart';
import 'package:bloc_login/features/screens/lead/screen/report.dart';
import 'package:bloc_login/features/screens/lead/screen/visits.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class LeadDashboard extends StatefulWidget {
  const LeadDashboard({super.key});

  @override
  State<LeadDashboard> createState() => _LeadDashboardState();
}

class _LeadDashboardState extends State<LeadDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const LeadHome(),
    const LeadBlocProvider(),
    const LeadVisit(),
    const LeadCall(),
    const LeadReport(),


  ];

  final List<IconData> _iconData = const [
    Icons.home,
    Icons.checklist_outlined,
    Icons.location_on_outlined,
    Icons.call,
    Icons.person_2_outlined,
  ];

  final List<String> _labels = const [
    'Home',
    'Lead',
    'Visits',
    'Calls',
    'Report',
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
    },);
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
