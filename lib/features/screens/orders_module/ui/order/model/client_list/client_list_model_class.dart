class ClientListModel {
  final int status;
  final List<ClientData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  ClientListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'] ?? 200,
        data = (json['data'] as List<dynamic>? ?? [])
            .map((e) => ClientData.fromJsonMap(e as Map<String, dynamic>))
            .toList(),
        totalPages = json['totalPages'] ?? 1,
        totalCount = json['totalCount'] ?? 0,
        pageNumber = json['pageNumber'] ?? 1,
        hasNextPage = json['hasNextPage'] ?? false,
        hasPreviousPage = json['hasPreviousPage'] ?? false,
        message = json['message'] ?? '';
}

class ClientData {
  final int id;
  final String branchId;
  final String branchName;
  final String customerName;
  final String customerCompanyName;
  final String email;
  final String whatsappNo;
  final String mobileNo;
  final String gstNo;
  final String address;
  final String status;
  final String createdAt;

  final String billingAddress;
  final String billingPincode;
  final String billingCountryId;
  final String billingStateId;
  final String billingCityId;

  final String shippingAddress;
  final String shippingPincode;
  final String shippingCountryId;
  final String shippingStateId;
  final String shippingCityId;

  final String billingCountryName;
  final String billingStateName;
  final String billingCityName;

  final String shippingCountryName;
  final String shippingStateName;
  final String shippingCityName;

  final String customerLevelName;

  ClientData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        branchId = json['branch_id'] ?? '',
        branchName = json['branch_name'] ?? '',
        customerName = json['customer_name'] ?? '',
        customerCompanyName = json['customer_company_name'] ?? '',
        email = json['email'] ?? '',
        whatsappNo = json['whatsapp_no'] ?? '',
        mobileNo = json['mobile_no'] ?? '',
        gstNo = json['gst_no'] ?? '',
        address = json['address'] ?? '',
        status = json['status'] ?? '',
        createdAt = json['created_at'] ?? '',
        billingAddress = json['billing_address'] ?? '',
        billingPincode = json['billing_pincode'] ?? '',
        billingCountryId = json['billing_country_id'] ?? '',
        billingStateId = json['billing_state_id'] ?? '',
        billingCityId = json['billing_city_id'] ?? '',
        shippingAddress = json['shipping_address'] ?? '',
        shippingPincode = json['shipping_pincode'] ?? '',
        shippingCountryId = json['shipping_country_id'] ?? '',
        shippingStateId = json['shipping_state_id'] ?? '',
        shippingCityId = json['shipping_city_id'] ?? '',
        billingCountryName = json['billing_country_name'] ?? '',
        billingStateName = json['billing_state_name'] ?? '',
        billingCityName = json['billing_city_name'] ?? '',
        shippingCountryName = json['shipping_country_name'] ?? '',
        shippingStateName = json['shipping_state_name'] ?? '',
        shippingCityName = json['shipping_city_name'] ?? '',
        customerLevelName = json['customer_level_name'] ?? '';
}
