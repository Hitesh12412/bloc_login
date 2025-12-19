import 'package:bloc_login/features/screens/employeemodule/payment.dart';
import 'package:bloc_login/features/screens/employeemodule/total_eraning.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PendingSalaryScreen extends StatefulWidget {
  const PendingSalaryScreen({super.key});

  @override
  State<PendingSalaryScreen> createState() => _PendingSalaryScreenState();
}

class _PendingSalaryScreenState extends State<PendingSalaryScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FBFF),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
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
        title: Text(
          "${DateFormat('MMM').format(DateTime.now())} Salary",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
        child: Column(
          children: [
            _buildSalaryHeader(),
            const SizedBox(height: 24),
            _buildSectionTitle(Icons.bar_chart, "Salary Breakdown"),
            const SizedBox(height: 14),
            _buildPayableSalaryCard(context),
            const SizedBox(height: 16),
            _buildSectionTitle(Icons.calendar_month, "Attendance Details"),
            const SizedBox(height: 14),
            _buildInfoTile(
              icon: Icons.check_circle_outline,
              iconBg: const Color(0x2F34A853),
              iconColor: const Color(0xFF34A853),
              title: "Payable Salary",
              subtitle: "0 days worked",
            ),
            _buildInfoTile(
              icon: Icons.holiday_village_outlined,
              iconBg: const Color(0x345E99FC),
              iconColor: const Color(0xFF5E99FC),
              title: "Paid Holiday",
              subtitle: "0 days",
            ),
            _buildInfoTile(
              icon: Icons.watch_later_outlined,
              iconBg: const Color(0x2CDF8755),
              iconColor: const Color(0xFFDF8755),
              title: "Half Day",
              subtitle: "0 days",
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(Icons.house_outlined, "Earning & Deductions"),
            const SizedBox(height: 14),
            _buildSimpleTile(Icons.watch_later_outlined, "Overtime", const Color(0x328F2B8E), const Color(0xFF8F2B8E)),
            _buildSimpleTile(Icons.star_border_purple500_outlined, "Bonus", const Color(0x34D8AD51), const Color(0xFFD8AD51)),
            _buildSimpleTile(Icons.check, "Allowance", const Color(0x304CA597), const Color(0xFF4CA597)),
            _buildSimpleTile(Icons.block, "Fines", const Color(0x37CA6767), const Color(0xFFCA6767)),
            _buildSimpleTile(Icons.trending_down_outlined, "Advance Payment", const Color(0x37CA6767), const Color(0xFFCA6767)),
            _buildSimpleTile(Icons.credit_card, "Salary Paid", const Color(0x2F1B2F50), const Color(0xFF1B2F50)),
            _buildSimpleTile(Icons.money_off, "Deductions", const Color(0x2FB32D2D), const Color(0xFFB32D2D)),
            const SizedBox(height: 30),
            _buildDownloadButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F62FE), Color(0xFF0A47A9)],
        ),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Salary",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM yyyy').format(DateTime.now()),
                      style: TextStyle(color: Colors.white.withOpacity(0.85)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "₹5,000.00",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2196F3)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPayableSalaryCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TotalEarnings()));
      },
      child: _cardWrapper(
        Row(
          children: [
            _iconBox(Icons.account_balance_wallet_outlined, const Color(0x2F34A853), const Color(0xFF34A853)),
            const SizedBox(width: 16),
            const Expanded(
              child: Text("Payable Salary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            const Text("₹0.00", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return _cardWrapper(
      Row(
        children: [
          _iconBox(icon, iconBg, iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Text("₹0.00", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSimpleTile(IconData icon, String title, Color bg, Color color) {
    return _cardWrapper(
      Row(
        children: [
          _iconBox(icon, bg, color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          const Text("₹0.00", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _iconBox(IconData icon, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: color),
    );
  }

  Widget _cardWrapper(Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8),
        ],
      ),
      child: child,
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const EmployeePayment()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.download_outlined, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Download Salary Slip',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
