class OrderListModel {
  final int status;
  final List<OrderData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  OrderListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'] ?? 200,
        data = (json['data'] as List<dynamic>)
            .map((e) => OrderData.fromJsonMap(e as Map<String, dynamic>))
            .toList(),
        totalPages = json['totalPages'] ?? 1,
        totalCount = json['totalCount'] ?? 0,
        pageNumber = json['pageNumber'] ?? 1,
        hasNextPage = json['hasNextPage'] ?? false,
        hasPreviousPage = json['hasPreviousPage'] ?? false,
        message = json['message'] ?? '';
}

class OrderData {
  final int id;
  final String branchId;
  final String branchName;
  final int status;
  final String orderNo;
  final String stockStatus;
  final String billingAddress;
  final String shippingAddress;
  final String createdAt;
  final String grandTotal;
  final String pendingAmount;
  final String receivedAmount;
  final String customerName;
  final String email;
  final String mobileNo;
  final String statusName;
  final String moduleStatus;
  final String statusTextColor;
  final String statusBgcolor;
  final String newTotalMrp;

  OrderData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        branchId = json['branch_id'],
        branchName = json['branch_name'],
        status = json['status'],
        orderNo = json['order_no'],
        stockStatus = json['stock_status'],
        billingAddress = json['billing_address'],
        shippingAddress = json['shipping_address'],
        createdAt = json['created_at'],
        grandTotal = json['grand_total'],
        pendingAmount = json['pending_amount'],
        receivedAmount = json['received_amount'],
        customerName = json['customer_name'],
        email = json['email'],
        mobileNo = json['mobile_no'],
        statusName = json['status_name'],
        moduleStatus = json['module_status'],
        statusTextColor = json['status_text_color'],
        statusBgcolor = json['status_bgcolor'],
        newTotalMrp = json['new_total_mrp'];
}
