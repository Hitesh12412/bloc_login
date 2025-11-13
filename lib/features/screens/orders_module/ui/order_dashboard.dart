import 'package:bloc_login/features/screens/orders_module/ui/Home_order.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/screens/order_list/order.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/screens/payment_history/payment_history.dart';
import 'package:bloc_login/features/screens/orders_module/ui/report.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class OrderDashboard extends StatefulWidget {
  const OrderDashboard({super.key});

  @override
  State<OrderDashboard> createState() => _OrderDashboardState();
}

class _OrderDashboardState extends State<OrderDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeOrder(),
    CreateOderScreen(userId: '1',),
    OrderPaymentHistory(),
    Report(),
  ];

  final List<IconData> _iconData = const [
    Icons.home,
    Icons.checklist_sharp,
    Icons.currency_rupee,
    Icons.person_2_rounded,
  ];

  final List<String> _labels = const [
    'Home',
    'Order',
    'Payment History',
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
