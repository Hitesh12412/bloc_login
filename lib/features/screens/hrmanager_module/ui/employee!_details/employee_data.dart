import 'package:bloc_login/features/screens/employeemodule/attendance.dart';
import 'package:bloc_login/features/screens/employeemodule/extra_fund.dart';
import 'package:bloc_login/features/screens/employeemodule/pending_salary_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/screen/agreement_list/agreement_list_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/award_screen/screen/award_list/award_list_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/education_screen/screen/education_list_screen/education_list_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/experience_screen/screen/exp_list_screen/exp_list_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/insurance_screen/screen/insurance_list_screen/insurance_list_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/screen/kyc_list_screen/kyc_list_screen.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee_details.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/month_ago.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeData extends StatefulWidget {
  final employee;
  const EmployeeData({super.key, required this.employee});

  @override
  State<EmployeeData> createState() => _EmployeeDataState();
}

class _EmployeeDataState extends State<EmployeeData> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      int newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final salary = widget.employee.salary;
    final profilePhoto = widget.employee.employeeProfile.isNotEmpty
        ? NetworkImage(
            "https://shiserp.com/demo/${widget.employee.employeeProfile}")
        : null;

    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),),
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
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: profilePhoto,
                        backgroundColor: Colors.blue.shade100,
                        child: profilePhoto == null
                            ? const Icon(Icons.person, size: 25, color: Colors.black)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.employee.name,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Employee ID: #${widget.employee.id}",
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (_) => [
                PopupMenuItem<String>(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EmployeeDetails(employee: widget.employee),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.edit, color: Colors.blue)),
                      const SizedBox(width: 8),
                      const Text('Edit Employee'),
                    ],
                  ),
                ),
              ],
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.more_vert, color: Colors.black),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Pending Salary",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.currency_rupee,
                                color: Colors.red, size: 20),
                            Text(
                              salary,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 260,
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildQuickActionsPage([
                      _buildAction(
                          Icons.payment, "Add Payment", Colors.teal, () {}),
                      _buildAction(Icons.calendar_month, "Attendance",
                          Colors.orange, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmployeeAttendance()),
                        );
                          }),
                      _buildAction(
                          Icons.timelapse, "Overtime", Colors.purple, () {}),
                      _buildAction(
                          Icons.attach_money, "Allowance", Colors.blue, () {}),
                      _buildAction(
                          Icons.money_off, "Deduction", Colors.red, () {}),
                      _buildAction(Icons.receipt_long, "Salary Slip",
                          Colors.green, () {}),
                      _buildAction(
                          Icons.edit, "Edit Salary", Colors.pink, () {}),
                      _buildAction(Icons.access_time_filled, "Check In/Out",
                          Colors.indigo, () {}),
                    ]),
                    _buildQuickActionsPage([
                      _buildAction(Icons.handshake, "Agreement", Colors.cyan,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AgreementListScreen(
                              employeeId: widget.employee.id.toString(),
                            ),
                          ),
                        );
                      }),
                      _buildAction(
                          Icons.star_rate_outlined, "Award", Colors.deepOrange,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AwardListScreen(
                              employeeId: widget.employee.id.toString(),
                            ),
                          ),
                        );
                      }),
                      _buildAction(Icons.collections_bookmark_sharp,
                          "Education", Colors.deepPurple, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EducationListScreen(
                              employeeId: widget.employee.id.toString(),
                            ),
                          ),
                        );
                      }),
                      _buildAction(
                          Icons.stacked_line_chart, "Experience", Colors.amber,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ExperienceListScreen(
                              employeeId: widget.employee.id.toString(),
                            ),
                          ),
                        );
                      }),
                      _buildAction(
                          Icons.health_and_safety, "Insurance", Colors.brown,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => InsuranceListScreen(
                              employeeId: widget.employee.id.toString(),
                            ),
                          ),
                        );
                      }),
                      _buildAction(Icons.verified_outlined, "KYC", Colors.grey,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => KycListScreen(
                              employeeId: widget.employee.id.toString(),
                            ),
                          ),
                        );
                      }),
                      _buildAction(Icons.document_scanner_rounded, "Documents",
                          Colors.lightBlue, () {}),
                      _buildAction(Icons.monetization_on_outlined, "Extra Fund",
                          Colors.green, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExtraFund()),
                        );
                      }),
                    ]),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.blue
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PendingSalaryScreen()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Current month salary calculation",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.blue,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.credit_card_sharp,
                                  color: Colors.green),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${DateFormat('MMM ,yyyy').format(DateTime.now())} Salary',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  size: 15,
                                  color: Colors.green,
                                ),
                                Text(
                                  widget.employee.salary,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Closing Balance',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MonthAgo()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Row(
                    children: [
                      Text(
                        DateFormat('MMM, yyyy').format(DateTime(DateTime.now().year, DateTime.now().month - 1)),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.employee.salary,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildQuickActionsPage(List<Widget> actions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 0.9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        physics: const NeverScrollableScrollPhysics(),
        children: actions,
      ),
    );
  }

  Widget _buildAction(
      IconData icon, String label, Color bgColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
