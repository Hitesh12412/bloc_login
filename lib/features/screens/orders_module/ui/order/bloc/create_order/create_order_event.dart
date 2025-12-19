abstract class OrderCreateEvent {}

class OrderCreateRequested extends OrderCreateEvent {
  final String userId;
  final String customerId;
  final String branchId;

  final String customerName;
  final String email;
  final String mobileNo;
  final String address;

  final String billingAddress;
  final String billingCountryId;
  final String billingStateId;
  final String billingCityId;
  final String billingPincode;

  final String shippingAddress;
  final String shippingCountryId;
  final String shippingStateId;
  final String shippingCityId;
  final String shippingPincode;

  final String description;
  final String orderProductData;
  final String? leadId;

  OrderCreateRequested({
    required this.userId,
    required this.customerId,
    required this.branchId,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.address,
    required this.billingAddress,
    required this.billingCountryId,
    required this.billingStateId,
    required this.billingCityId,
    required this.billingPincode,
    required this.shippingAddress,
    required this.shippingCountryId,
    required this.shippingStateId,
    required this.shippingCityId,
    required this.shippingPincode,
    required this.description,
    required this.orderProductData,
    this.leadId,
  });
}
