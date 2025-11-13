import 'package:bloc_login/features/screens/purchase/screens/purchase_report.dart';
import 'package:bloc_login/features/screens/purchase/screens/received_notice.dart';
import 'package:bloc_login/features/screens/purchase/screens/return_request.dart';
import 'package:flutter/material.dart';

class PurchaseMore extends StatelessWidget {
  PurchaseMore({super.key});

  Color _getIconColor(String moduleName) {
    switch (moduleName) {
      case 'Notice':
        return Colors.blue;
      case 'Request':
        return Colors.purple;
      case 'Report':
        return Colors.orange;
      default:
        return Colors.blueAccent;
    }
  }


  IconData _getFallbackIcon(String moduleName) {
    switch (moduleName) {
      case 'Notice':
        return Icons.person;
      case 'Request':
        return Icons.groups;
      case 'Report':
        return Icons.task;
      default:
        return Icons.dashboard;
    }
  }

    final List<Widget> moduleScreens = [
      const ReceivedNotice(),
      const ReturnRequest(),
      const PurchaseReport(),
    ];

    final List<String> moduleNames = [
      'Notice',
      'Request',
      'Report',
    ];

    final List<String> moduleIconPaths = [
      'assets/icons/Notice.png',
      'assets/icons/Request.png',
      'assets/icons/Report.png',
    ];


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.read_more,color: Colors.blue,)),
            const SizedBox(width: 10,),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("More",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                Text('Manage your purchase efficiently',style: TextStyle(color: Colors.white,fontSize: 12,),)
              ],
            ),
          ],
        ),
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: moduleNames.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final moduleName = moduleNames[index];
                    final iconColor = _getIconColor(moduleName);
                    return GestureDetector(
                      onTap: () {
                        _navigateToModule(context, moduleName, moduleScreens[index]);
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
                              padding: const EdgeInsets.all(16),
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
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToModule(BuildContext context, String moduleName, Widget screen) {
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
