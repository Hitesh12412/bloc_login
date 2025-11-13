import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bloc_login/features/screens/Reminders/ui/reminders_screen.dart';
import 'package:bloc_login/features/screens/customer_module/ui/customer_dashboard.dart';
import 'package:bloc_login/features/screens/dispatch/dash/dispatch_dash.dart';
import 'package:bloc_login/features/screens/employeemodule/employee_dash.dart';
import 'package:bloc_login/features/screens/file_manager/File_manager.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/hr_dsah.dart';
import 'package:bloc_login/features/screens/inventory/dash/inventory_dash.dart';
import 'package:bloc_login/features/screens/lead/dashboard/lead_dashboard.dart';
import 'package:bloc_login/features/screens/notes/ui/notes_screen.dart';
import 'package:bloc_login/features/screens/notification/screens/notification_screen.dart';
import 'package:bloc_login/features/screens/production/dash/production_dash.dart';
import 'package:bloc_login/features/screens/purchase/dash/purchase_dash.dart';
import 'package:bloc_login/features/screens/support/screens/support_screen.dart';
import 'package:bloc_login/features/screens/task_module/ui/task_dash.dart';
import 'package:bloc_login/features/screens/vendor/dash/vendor_dash.dart';
import 'package:flutter/material.dart';
import 'package:bloc_login/features/screens/loginpage/ui/login_screen.dart';
import 'package:bloc_login/features/screens/setting_module/ui/settings.dart';
import 'package:bloc_login/features/screens/product_module/screen/products_list_screen/products_screen.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order_dashboard.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  Color _getIconColor(String moduleName) {
    switch (moduleName) {
      case 'Employee':
        return Colors.blue;
      case 'HR Manager':
        return Colors.purple;
      case 'Task':
        return Colors.orange;
      case 'Customer':
        return Colors.green;
      case 'Product':
        return Colors.red;
      case 'Orders':
        return Colors.teal;
      case 'Reminders':
        return Colors.indigo;
      case 'Setting':
        return Colors.pink;
      case 'Notes':
        return Colors.brown;
      case 'Lead':
        return Colors.amber;
      case 'dispatch':
        return Colors.cyan;
      case 'Support':
        return Colors.lightBlue;
      case 'Production':
        return Colors.lightGreen;
      case 'Purchase':
        return Colors.deepPurple;
      case 'File Manager':
        return Colors.deepOrange;
      case 'Inventory':
        return Colors.deepOrange;
      case 'Vendor':
        return Colors.deepOrange;
      default:
        return Colors.blueAccent;
    }
  }

  IconData _getFallbackIcon(String moduleName) {
    switch (moduleName) {
      case 'Employee':
        return Icons.person;
      case 'HR Manager':
        return Icons.groups;
      case 'Task':
        return Icons.task;
      case 'Customer':
        return Icons.support_agent_rounded;
      case 'Product':
        return Icons.shopping_cart;
      case 'Orders':
        return Icons.shopping_bag;
      case 'Reminders':
        return Icons.notification_add;
      case 'Setting':
        return Icons.settings;
      case 'Notes':
        return Icons.note_alt_sharp;
      case 'Lead':
        return Icons.leak_add;
      case 'dispatch':
        return Icons.delivery_dining;
      case 'Support':
        return Icons.support_agent;
      case 'Production':
        return Icons.production_quantity_limits;
      case 'Purchase':
        return Icons.shopping_cart;
      case 'File Manager':
        return Icons.folder;
      case 'Inventory':
        return Icons.inventory;
      case 'Vendor':
        return Icons.insert_chart_outlined_sharp;
      default:
        return Icons.dashboard;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> moduleScreens = [
      const EmployeeDashboard(),
      const HrDash(),
      const TaskDashboard(),
      const CustomerDashboard(),
      const ProductsBlocProvider(),
      const OrderDashboard(),
      const RemindersScreen(),
      const SettingsScreen(),
      const NotesScreen(),
      const LeadDashboard(),
      const DispatchDashboard(),
      const SupportBlocProvider(),
      const ProductionDashboard(),
      const PurchaseDashboard(),
      const FileManager(),
      const InventoryDashboard(),
      const VendorDashboard(),
      const NotificationScreen(),
    ];
    final List<String> moduleNames = [
      'Employee',
      'HR Manager',
      'Task',
      'Customer',
      'Product',
      'Orders',
      'Reminders',
      'Setting',
      'Notes',
      'Lead',
      'dispatch',
      'Support',
      'Production',
      'Purchase',
      'File Manager',
      'Inventory',
      'Vendor',
      'Notification'
    ];
    final List<String> moduleIconPaths = [
      'assets/icons/employee.png',
      'assets/icons/hr_manager.png',
      'assets/icons/task.png',
      'assets/icons/customer.png',
      'assets/icons/product.png',
      'assets/icons/orders.png',
      'assets/icons/reminders.png',
      'assets/icons/settings.png',
      'assets/icons/notes.png',
      'assets/icons/lead.png',
      'assets/icons/dispatch.png',
      'assets/icons/support.png',
      'assets/icons/production.png',
      'assets/icons/purchase.png',
      'assets/icons/folder.png',
      'assets/icons/inventory.png',
      'assets/icons/Vendor.png',
      'assets/icons/notification.png'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose Module",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Divider(
              color: Colors.blue,
              thickness: 5,
              height: 10,
              endIndent: 300,
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child:
                const Icon(Icons.qr_code_scanner, size: 28, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 30,
                            right: 10,
                            left: 10,
                            top: 20,
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 40,
                                      height: 5,
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'How Can I Help You ?',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.blue.shade700),
                                        ),
                                        child: Icon(Icons.keyboard_arrow_up,
                                            color: Colors.blue.shade700),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Future.delayed(
                                        const Duration(milliseconds: 100),
                                        () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) {
                                              bool innerIsListening = true;
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .viewInsets
                                                                  .bottom +
                                                              20,
                                                      left: 10,
                                                      right: 10,
                                                      top: 20,
                                                    ),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .blue
                                                                        .shade700),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        innerIsListening =
                                                                            !innerIsListening;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: innerIsListening
                                                                            ? Colors.blue.shade700
                                                                            : Colors.grey.shade400,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        innerIsListening
                                                                            ? Icons.mic_none
                                                                            : Icons.mic_off_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            28,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Expanded(
                                                                    child:
                                                                        TextField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Speak or type here..',
                                                                        hintStyle:
                                                                            TextStyle(color: Colors.blue.shade700),
                                                                        border:
                                                                            InputBorder.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: AvatarGlow(
                                      animate: true,
                                      endRadius: 35.0,
                                      glowColor: Colors.blue.shade700,
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      repeat: true,
                                      showTwoGlows: true,
                                      child: Material(
                                        elevation: 10.0,
                                        shape: const CircleBorder(),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.blue.shade500,
                                          radius: 25.0,
                                          child: const Icon(Icons.mic_none,
                                              color: Colors.white, size: 30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Try asking about Employee, Task, Customer modules...',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Tap mic to start or type your query',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.mic, size: 28),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.power_settings_new, color: Colors.blue),
              onPressed: () => showModalBottomSheet(
                isDismissible: false,
                enableDrag: false,
                context: context,
                barrierColor: Colors.black.withOpacity(0.4),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();},
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.grey),),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text("Logged out successfully"),
                                    backgroundColor: Colors.green.shade600,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                );},
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  border: Border.all(color: Colors.red.shade100),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text('Log Out',style: TextStyle(fontSize: 16,color: Colors.red),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            padding:
                const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.lightBlue.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.blueAccent.shade100),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.waving_hand,
                      color: Colors.blue, size: 25),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    "Welcome back,#ts1245 - Hitesh!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                itemCount: moduleNames.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final moduleName = moduleNames[index];
                  final iconColor = _getIconColor(moduleName);
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
                              width: 55,
                              height: 55,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  _getFallbackIcon(moduleName),
                                  size: 40,
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
          ),
        ],
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
