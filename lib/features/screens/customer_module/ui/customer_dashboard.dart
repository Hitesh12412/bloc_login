import 'package:bloc_login/features/screens/customer_module/customer/screen/customer_list_screen/customer_screen.dart';
import 'package:bloc_login/features/screens/customer_module/ui/customer_payment_history.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CustomerList(),
    const CustomerPaymentHistory(),

  ];

  final List<IconData> _iconData = const [
    Icons.home,
    Icons.currency_rupee,

  ];

  final List<String> _labels = const [
    'Home',
    'Payment History',
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
