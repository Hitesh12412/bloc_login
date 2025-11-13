class Employee {
  final int id;
  final String name;
  final String mobileNo;
  final String categoryName;
  final String salary;
  final String salaryPayType;
  final String employeeCode;
  final String employeeProfile;
  final String employeeFace;
  final int status;
  final String ptStatus;
  final String pfStatus;
  final String esiStatus;
  final int currentMonthSalary;
  final String employeePaidSalary;
  final String employeeAdvanceSalary;
  final String employeeDebitAmount;
  final int pendingSalary;
  final String perDaySalary;
  final String todayAttendance;

  Employee({
    required this.id,
    required this.name,
    required this.mobileNo,
    required this.categoryName,
    required this.salary,
    required this.salaryPayType,
    required this.employeeCode,
    required this.employeeProfile,
    required this.employeeFace,
    required this.status,
    required this.ptStatus,
    required this.pfStatus,
    required this.esiStatus,
    required this.currentMonthSalary,
    required this.employeePaidSalary,
    required this.employeeAdvanceSalary,
    required this.employeeDebitAmount,
    required this.pendingSalary,
    required this.perDaySalary,
    required this.todayAttendance,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      categoryName: json['category_name'] ?? '',
      salary: json['salary'] ?? '0',
      salaryPayType: json['salary_pay_type'] ?? '',
      employeeCode: json['employee_code'] ?? '',
      employeeProfile: json['employee_profile'] ?? '',
      employeeFace: json['employee_face'] ?? '',
      status: json['status'] ?? 0,
      ptStatus: json['pt_status'] ?? '',
      pfStatus: json['pf_status'] ?? '',
      esiStatus: json['esi_status'] ?? '',
      currentMonthSalary: json['current_month_salary'] ?? 0,
      employeePaidSalary: json['employee_paid_salary'] ?? '0',
      employeeAdvanceSalary: json['employee_advance_salary'] ?? '0',
      employeeDebitAmount: json['employee_debit_amonut'] ?? '0',
      pendingSalary: json['pending_salary'] ?? 0,
      perDaySalary: json['per_day_salary'] ?? '0.00',
      todayAttendance: json['today_attendance'] ?? '',
    );
  }
}
