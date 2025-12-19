import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveManagement extends StatefulWidget {
  const LeaveManagement({super.key});

  @override
  State<LeaveManagement> createState() => _LeaveManagementState();
}

class _LeaveManagementState extends State<LeaveManagement> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
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
        title: const Text(
          "Leave Management",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _summaryCard(
                        color: Colors.blue,
                        icon: Icons.account_balance_wallet,
                        title: 'Upcoming Leave',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _summaryCard(
                        color: Colors.green,
                        icon: Icons.check_circle,
                        title: 'Approved',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _summaryCard(
                        color: Colors.orange,
                        icon: Icons.access_time_outlined,
                        title: 'Pending',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _summaryCard(
                        color: Colors.red,
                        icon: Icons.cancel,
                        title: 'Cancelled',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildToggleTabs(),
          const SizedBox(height: 10),
          Expanded(
            child: selectedIndex == 0
                ? ListView(children: _buildPastCards())
                : _buildNoDataFound(),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard({
    required Color color,
    required IconData icon,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const Spacer(),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "00",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildToggleTabs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tabWidth = constraints.maxWidth / 3;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 42,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                alignment: selectedIndex == 0
                    ? Alignment.centerLeft
                    : selectedIndex == 1
                    ? Alignment.center
                    : Alignment.centerRight,
                child: Container(
                  width: tabWidth,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              Row(
                children: List.generate(3, (i) {
                  final text =
                  i == 0 ? 'Past' : i == 1 ? 'Today' : 'Upcoming';
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedIndex = i),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            color: selectedIndex == i
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildPastCards() {
    return [
      Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hitesh',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 15, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                _statusChip(
                  icon: Icons.access_time_outlined,
                  color: Colors.orange,
                  text: 'Pending',
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _infoColumn(
                      icon: Icons.today,
                      label: 'Duration',
                      value: '1 Day',
                      color: Colors.blue),
                  const Spacer(),
                  _infoColumn(
                      icon: Icons.account_balance_wallet,
                      label: 'Leave Balance',
                      value: '00',
                      color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _infoColumn({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _statusChip({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildNoDataFound() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://cdni.iconscout.com/illustration/premium/thumb/no-data-found-illustration-download-in-svg-png-gif-file-formats--office-computer-digital-work-business-pack-illustrations-7265556.png',
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 10),
          const Text("Data Not Found!"),
        ],
      ),
    );
  }
}
