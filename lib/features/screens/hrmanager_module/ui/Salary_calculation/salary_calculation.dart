import 'package:flutter/material.dart';

class SalaryCalculation extends StatefulWidget {
  const SalaryCalculation({super.key});

  @override
  State<SalaryCalculation> createState() => _SalaryCalculationState();
}

class _SalaryCalculationState extends State<SalaryCalculation> {
  int _selectedIndex = 0;
  final int _originalSelectedIndex = 0;

  final List<_MethodInfo> _methods = [
    _MethodInfo(
      title: "30 Days Every Month",
      subtitle: "Fixed 30 days calculation",
      info: "February - 30 days, March - 30 days",
      icon: Icons.calendar_month,
      color: Colors.blue,
      bgSelected: Colors.blue.shade100,
    ),
    _MethodInfo(
      title: "Calendar Month",
      subtitle: "Actual calendar days",
      info: "February - 28 days, March - 31 days",
      icon: Icons.date_range,
      color: Colors.green,
      bgSelected: Colors.green.shade100,
    ),
    _MethodInfo(
      title: "Exclude Week-offs",
      subtitle: "Working days only",
      info: "28 days with 4 week-offs = 24 working days",
      icon: Icons.work,
      color: Colors.orange,
      bgSelected: Colors.orange.shade100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isChanged = _selectedIndex != _originalSelectedIndex;


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
                const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20,),
          ),
        ),
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        title: const Text(
          'Salary Calculation Method',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100,),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.calculate_rounded,
                        color: Colors.white, size: 28,),
                  ),
                  const SizedBox(width: 18),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose Calculation Method",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 19),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Select how monthly salaries should be calculated",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(
              _methods.length,
              (int i) {
                final method = _methods[i];
                final bool selected = i == _selectedIndex;

                return Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: selected ? Colors.blue.shade50 : Colors.white,
                    border: Border.all(
                      color:
                          selected ? Colors.blue : Colors.grey.withOpacity(0.2),
                      width: selected ? 2 : 1.3,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(
                        () {
                          _selectedIndex = i;
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? method.bgSelected
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  method.icon,
                                  color: selected ? method.color : Colors.grey,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(height: 11),
                              selected
                                  ? Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                      child: const Icon(Icons.check,
                                          color: Colors.white, size: 16),
                                    )
                                  : Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.grey.shade400,
                                            width: 2),
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color:
                                        selected ? method.color : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  method.subtitle,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                const SizedBox(height: 7),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? method.bgSelected
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Text(
                                    method.info,
                                    style: TextStyle(
                                      fontWeight: selected
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      color:
                                          selected ? method.color : Colors.grey,
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
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings Updated'),
                    ),
                  );
                },
                icon: Icon(isChanged ? Icons.update : Icons.arrow_back),
                label: Text(
                  isChanged ? 'Update Settings' : 'Back',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isChanged ? Colors.blue : Colors.grey.shade300,
                  foregroundColor: isChanged ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodInfo {
  final String title;
  final String subtitle;
  final String info;
  final IconData icon;
  final Color color;
  final Color bgSelected;

  const _MethodInfo(
      {required this.title,
      required this.subtitle,
      required this.info,
      required this.icon,
      required this.color,
      required this.bgSelected});
}
