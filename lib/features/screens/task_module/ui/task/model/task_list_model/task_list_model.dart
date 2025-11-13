class TaskListModel {
  final int status;
  final List<TaskData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  TaskListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'] ?? 200,
        data = List<TaskData>.from(
            (json['data'] as List).map((e) => TaskData.fromJsonMap(e))),
        totalPages = json['totalPages'] ?? 1,
        totalCount = json['totalCount'] ?? 0,
        pageNumber = json['pageNumber'] ?? 1,
        hasNextPage = json['hasNextPage'] ?? false,
        hasPreviousPage = json['hasPreviousPage'] ?? false,
        message = json['message'] ?? '';
}

class TaskData {
  final int id;
  final int adminId;
  final int createdBy;
  final String taskName;
  final String description;
  final String remark;
  final String status;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String? employeeId;
  final String? employeeName;
  final String taskPriority;

  TaskData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        adminId = json['admin_id'],
        createdBy = json['created_by'],
        taskName = json['task_name'],
        description = json['description'],
        remark = json['remark'],
        status = json['status'],
        startDate = json['start_date'],
        endDate = json['end_date'],
        createdAt = json['created_at'],
        employeeId = json['employee_id']?.toString(),
        employeeName = json['employee_name'],
        taskPriority = json['task_priority'];
}
