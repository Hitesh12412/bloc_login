import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeAttendance extends StatefulWidget {
  const EmployeeAttendance({super.key});

  @override
  State<EmployeeAttendance> createState() => _EmployeeAttendanceState();
}

class _EmployeeAttendanceState extends State<EmployeeAttendance> {
  DateTime _selectedDate = DateTime(2025, 7, 9);
  DateTime _currentMonth = DateTime(2025, 7);

  List<DateTime> absentDates = [
    for (int day in [1, 2, 3, 4, 7, 8, 9]) DateTime(2025, 7, day),
  ];

  List<DateTime> weekendDates = [
    DateTime(2025, 7, 5),
    DateTime(2025, 7, 6),
  ];

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          'Attendance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            _buildMonthCard(),
            const SizedBox(height: 10),
            _buildCalendarContainer(),
            const SizedBox(height: 20),
            _buildAttendanceOverview(),
            const SizedBox(height: 20),
          ],
        ),
      ),

    );
  }

  Widget _buildMonthCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year,
                  _currentMonth.month - 1,
                );
              });
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.blue, size: 20),
          ),
          Text(
            DateFormat.yMMM().format(_currentMonth),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year,
                  _currentMonth.month + 1,
                );
              });
            },
            child: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          _buildWeekdays(),
          const SizedBox(height: 10),
          _buildCalendarGrid(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }


  Widget _buildWeekdays() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final start = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(start.year, start.month);
    final firstWeekday = start.weekday;
    final totalCells = daysInMonth + firstWeekday - 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalCells,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        if (index < firstWeekday - 1) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300), // <-- box look
            ),
          );
        }

        final day = index - firstWeekday + 2;
        final date = DateTime(_currentMonth.year, _currentMonth.month, day);
        final isSelected = _isSameDate(date, _selectedDate);

        return GestureDetector(
          onTap: () => setState(() => _selectedDate = date),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? Colors.blue
                    : Colors.grey.shade300, // border on all days
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    '$day',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttendanceOverview() {
    final List<Map<String, dynamic>> data = [
      {
        'title': 'Present',
        'count': '0',
        'icon': Icons.check_circle,
        'color': Colors.green
      },
      {
        'title': 'Week-Off Present',
        'count': '0',
        'icon': Icons.work,
        'color': Colors.green
      },
      {
        'title': 'Absent',
        'count': '7',
        'icon': Icons.cancel,
        'color': Colors.red
      },
      {
        'title': 'Half Day',
        'count': '0',
        'icon': Icons.access_time,
        'color': Colors.orange
      },
      {
        'title': 'Paid Leave',
        'count': '0',
        'icon': Icons.beach_access,
        'color': Colors.blue
      },
      {
        'title': 'Festival Holiday Present',
        'count': '0',
        'icon': Icons.celebration,
        'color': Colors.orange
      },
      {
        'title': 'Overtime',
        'count': '00:00 hrs',
        'icon': Icons.timer,
        'color': Colors.grey
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.bar_chart, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Attendance Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemBuilder: (context, index) {
              final item = data[index];
              return _buildOverviewCard(
                title: item['title'],
                count: item['count'].toString(),
                icon: item['icon'] as IconData,
                color: item['color'] as Color,
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _buildOverviewCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            spreadRadius: 1,
          )
        ],
        border: Border.all(
          color: title == 'Week-Off Present' ? Colors.green : Colors.white,
          width: title == 'Week-Off Present' ? 1.5 : 0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 25),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          )
        ],
      ),
    );
  }



}
