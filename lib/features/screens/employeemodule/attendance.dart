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

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width * 0.05;

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
        title: const Text(
          'Attendance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildMonthCard(),
            const SizedBox(height: 12),
            _buildCalendarContainer(),
            const SizedBox(height: 24),
            _buildAttendanceOverview(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthCard() {
    return Container(
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
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildWeekdays(),
          const SizedBox(height: 10),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildWeekdays() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = constraints.maxWidth / 7;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: totalCells,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            if (index < firstWeekday - 1) {
              return Container(
                height: cellSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              );
            }

            final day = index - firstWeekday + 2;
            final date = DateTime(_currentMonth.year, _currentMonth.month, day);
            final isSelected = _isSameDate(date, _selectedDate);

            return GestureDetector(
              onTap: () => setState(() => _selectedDate = date),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  '$day',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAttendanceOverview() {
    final data = [
      ('Present', '0', Icons.check_circle, Colors.green),
      ('Week-Off Present', '0', Icons.work, Colors.green),
      ('Absent', '7', Icons.cancel, Colors.red),
      ('Half Day', '0', Icons.access_time, Colors.orange),
      ('Paid Leave', '0', Icons.beach_access, Colors.blue),
      ('Festival Holiday Present', '0', Icons.celebration, Colors.orange),
      ('Overtime', '00:00 hrs', Icons.timer, Colors.grey),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? 3 : 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: isTablet ? 1.8 : 1.5,
              ),
              itemBuilder: (context, index) {
                return _buildOverviewCard(
                  title: data[index].$1,
                  count: data[index].$2,
                  icon: data[index].$3,
                  color: data[index].$4,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildOverviewCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 170;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4)
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
                      color: color.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: isSmall ? 20 : 24),
                  ),
                  const Spacer(),
                  Text(
                    count,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmall ? 16 : 20,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
