import 'package:bloc_login/features/screens/employeemodule/pending_salary_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeePayment extends StatefulWidget {
  const EmployeePayment({super.key});

  @override
  State<EmployeePayment> createState() => _EmployeePaymentState();
}

class _EmployeePaymentState extends State<EmployeePayment> {
  
  Map<String, double> getClosingBalanceData() {
    DateTime now = DateTime.now();
    DateTime previousMonth = DateTime(now.year, now.month - 1, 1);
    DateTime twoMonthsAgo = DateTime(now.year, now.month - 2, 1);

    return {
      DateFormat('MMM, yyyy').format(previousMonth): 2500.0,
      DateFormat('MMM, yyyy').format(twoMonthsAgo): 1800.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final closingBalanceData = getClosingBalanceData();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
            const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
        ),
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Payment Report",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.red.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Pending Salary",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_rounded,
                          color: Colors.red,
                        ),
                        Text(
                          "67",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PendingSalaryScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Current month salary calculation',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 18)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.money,
                            color: Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${DateFormat('MMM, yyyy').format(
                            DateTime.now(),
                          )} Salary",
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.currency_rupee_rounded,
                          size: 17,
                          color: Colors.green,
                        ),
                        const Text(
                          "67",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              'Previous Months Closing Balance',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          
          Expanded(
            child: ListView.builder(
              itemCount: closingBalanceData.length,
              itemBuilder: (context, index) {
                String monthYear = closingBalanceData.keys.elementAt(index);
                double balance = closingBalanceData.values.elementAt(index);
                bool isRecentMonth = index == 0; 

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: isRecentMonth
                        ? Border.all(color: Colors.orange.withOpacity(0.5), width: 2)
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isRecentMonth
                                ? Colors.orange.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.account_balance,
                            color: isRecentMonth ? Colors.orange : Colors.grey.shade600,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                monthYear,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isRecentMonth ? Colors.orange : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Closing Balance',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.currency_rupee_rounded,
                                  size: 18,
                                  color: isRecentMonth ? Colors.orange : Colors.black87,
                                ),
                                Text(
                                  balance.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isRecentMonth ? Colors.orange : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            if (isRecentMonth)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Recent',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
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
    );
  }
}
