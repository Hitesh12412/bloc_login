import 'package:flutter/material.dart';

class SalaryStructure extends StatefulWidget {
  const SalaryStructure({super.key});

  @override
  State<SalaryStructure> createState() => _SalaryStructureState();
}

class _SalaryStructureState extends State<SalaryStructure> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Salary Structure",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildToggleTabs(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: selectedIndex == 0
                    ? _buildEarningsCards()
                    : _buildDeductionsCards(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTabs() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            alignment: selectedIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 32,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedIndex = 0),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Earnings',
                      style: TextStyle(
                        color: selectedIndex == 0 ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedIndex = 1),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Deductions',
                      style: TextStyle(
                        color: selectedIndex == 1 ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  List<Widget> _buildEarningsCards() {
    return [
      _salaryCard(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Basic Salary',
        value: '78.0%',
        valueColor: Colors.blue,
        badge: 'BASE',
      ),
      _salaryCard(
        icon: Icons.trending_up,
        title: 'HRA',
        value: '10.0%',
        valueColor: Colors.green,
      ),
      _salaryCard(
        icon: Icons.trending_up,
        title: 'Medical Allowance',
        value: '12.0%',
        valueColor: Colors.green,
      ),
    ];
  }

  List<Widget> _buildDeductionsCards() {
    return [
      _salaryCard(
        icon: Icons.trending_down,
        title: 'PT',
        value: '₹ 200',
        valueColor: Colors.red,
      ),
      _salaryCard(
        icon: Icons.trending_down,
        title: 'PF',
        value: '2.0%',
        valueColor: Colors.red,
      ),
      _salaryCard(
        icon: Icons.trending_down,
        title: 'ESI',
        value: '₹ 80',
        valueColor: Colors.red,
      ),
    ];
  }

  Widget _salaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color valueColor,
    String? badge,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: valueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: valueColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Active',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
