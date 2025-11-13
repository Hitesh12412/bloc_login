import 'package:flutter/material.dart';

class WeekOffDays extends StatefulWidget {
  const WeekOffDays({super.key});

  @override
  State<WeekOffDays> createState() => _WeekOffDaysState();
}

class _WeekOffDaysState extends State<WeekOffDays> {
  final List<_DayInfo> _days = [
    _DayInfo(name: "Sunday", icon: Icons.wb_sunny, color: Colors.blue.shade700),
    const _DayInfo(name: "Monday", icon: Icons.work, color: Colors.grey),
    const _DayInfo(name: "Tuesday", icon: Icons.apartment, color: Colors.grey),
    const _DayInfo(name: "Wednesday", icon: Icons.show_chart, color: Colors.grey),
    const _DayInfo(name: "Thursday", icon: Icons.access_time, color: Colors.grey),
    const _DayInfo(name: "Friday", icon: Icons.campaign, color: Colors.grey),
    _DayInfo(name: "Saturday", icon: Icons.work, color: Colors.blue.shade700),
  ];

  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    // Pre-select Saturday and Sunday (first, last index)
    _selected = List.generate(_days.length, (i) => (i == 0 || i == 6));
  }

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
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        title: const Text("Add Week-Off Days",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.calendar_today_rounded, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Text('Select Week-Off Days',
                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Choose the days when your team will be off work', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: List.generate(_days.length * 2 - 1, (index) {
                  if (index.isOdd) {
                    return const Divider(
                      color: Colors.grey,
                      thickness: 1.1,
                      indent: 16,
                      endIndent: 16,
                    );
                  }
                  final i = index ~/ 2;
                  final selected = _selected[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      color: selected ? Colors.blue.shade50 : null,
                      borderRadius: BorderRadius.circular(12),
                      border: selected ? Border.all(color: Colors.blue.shade200) : null,
                    ),
                    child: ListTile(
                      onTap: () {
                        setState(() => _selected[i] = !_selected[i]);
                      },
                      leading: Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        activeColor: Colors.blue,
                        value: selected,
                        onChanged: (_) => setState(() => _selected[i] = !_selected[i]),
                      ),
                      title: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selected ? Colors.blue.shade100 : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(_days[i].icon,
                                color: selected ? Colors.blue : Colors.grey),
                          ),
                          const SizedBox(width: 15),
                          Text(_days[i].name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.blue : Colors.black,
                              )),
                          const Spacer(),
                          if (selected)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text('Selected',
                                  style:
                                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13)),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Week-Off Days Updated'),
                    ),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Week-Off Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayInfo {
  final String name;
  final IconData icon;
  final Color color;
  const _DayInfo({required this.name, required this.icon, required this.color});
}
