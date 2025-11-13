import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportTaskMore extends StatefulWidget {
  const ReportTaskMore({super.key});

  @override
  State<ReportTaskMore> createState() => _ReportTaskMoreState();
}

class _ReportTaskMoreState extends State<ReportTaskMore> {
  DateTime? fromDate;
  DateTime? toDate;
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController taskController = TextEditingController();

  final List<String> taskOptions = [
    'All',
    'Pending',
    'In Progress',
    'Rejected',
    'Completed',
  ];

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    taskController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? (fromDate ?? DateTime.now()) : (toDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
          fromDateController.text = DateFormat('dd/MM/yyyy').format(picked);
        } else {
          toDate = picked;
          toDateController.text = DateFormat('dd/MM/yyyy').format(picked);
        }
      });
    }
  }

  InputDecoration _customInputDecoration(String label) {
    bool isDate = label.contains('Date');
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: isDate
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.calendar_today,
            color: Colors.blue,
            size: 20,
          ),
        ),
      )
          : null,
    );
  }

  Widget _buildShadowedField(Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
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
        title: const Text(
          "Task Report",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildShadowedField(
              TextFormField(
                controller: fromDateController,
                decoration: _customInputDecoration('Start Date (From)'),
                readOnly: true,
                onTap: () => _selectDate(context, true),
              ),
            ),
            _buildShadowedField(
              TextFormField(
                controller: toDateController,
                decoration: _customInputDecoration('End Date (To)'),
                readOnly: true,
                onTap: () => _selectDate(context, false),
              ),
            ),
            _buildShadowedField(
              DropdownButtonFormField<String>(
                value: taskController.text.isNotEmpty ? taskController.text : null,
                decoration: _customInputDecoration('Select Task'),
                items: taskOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    taskController.text = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add your download logic here
                },
                icon: const Icon(Icons.download),
                label: const Text(
                  'Download',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
