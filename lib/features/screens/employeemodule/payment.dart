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
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width * 0.04;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(9),
            padding: const EdgeInsets.only(left: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
        ),
        title: const Text(
          "Payment Report",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: _buildPendingSalaryCard(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: _buildCurrentMonthCard(context),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: const Text(
              'Previous Months Closing Balance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              itemCount: closingBalanceData.length,
              itemBuilder: (context, index) {
                final monthYear = closingBalanceData.keys.elementAt(index);
                final balance = closingBalanceData.values.elementAt(index);
                final isRecent = index == 0;

                return _buildClosingBalanceTile(
                  monthYear: monthYear,
                  balance: balance,
                  isRecent: isRecent,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingSalaryCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.4)),
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
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Total Pending Salary",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.currency_rupee_rounded, color: Colors.red),
                  Text(
                    "67",
                    style: TextStyle(
                      fontSize: 24,
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
    );
  }

  Widget _buildCurrentMonthCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PendingSalaryScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Current month salary calculation',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 18),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.money, color: Colors.green.shade700),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "${DateFormat('MMM, yyyy').format(DateTime.now())} Salary",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.currency_rupee_rounded,
                    size: 18,
                    color: Colors.green,
                  ),
                  const Text(
                    "67",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClosingBalanceTile({
    required String monthYear,
    required double balance,
    required bool isRecent,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
        border: isRecent
            ? Border.all(color: Colors.orange.withOpacity(0.6), width: 2)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isRecent
                    ? Colors.orange.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.account_balance,
                color: isRecent ? Colors.orange : Colors.grey.shade600,
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
                      color: isRecent ? Colors.orange : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Closing Balance',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.currency_rupee_rounded,
                      size: 18,
                      color: isRecent ? Colors.orange : Colors.black87,
                    ),
                    Text(
                      balance.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isRecent ? Colors.orange : Colors.black87,
                      ),
                    ),
                  ],
                ),
                if (isRecent)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
  }
}
