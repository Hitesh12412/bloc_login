class BranchListModel {
  final int status;
  final List<BranchData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  BranchListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'] ?? 200,
        data = (json['data'] as List<dynamic>? ?? [])
            .map((e) => BranchData.fromJsonMap(e))
            .toList(),
        totalPages = json['totalPages'] ?? 1,
        totalCount = json['totalCount'] ?? 0,
        pageNumber = json['pageNumber'] ?? 1,
        hasNextPage = json['hasNextPage'] ?? false,
        hasPreviousPage = json['hasPreviousPage'] ?? false,
        message = json['message'] ?? '';
}

class BranchData {
  final int id;
  final String name;

  BranchData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '';
}
