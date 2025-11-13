import 'package:equatable/equatable.dart';

class ProductionDetailModel extends Equatable {
  final int status;
  final OrderDetail data;
  final String message;

  const ProductionDetailModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ProductionDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductionDetailModel(
      status: json['status'] ?? '',
      data: OrderDetail.fromJson(json['data'] ?? {}),
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.toJson(),
    'message': message,
  };

  @override
  List<Object?> get props => [status, data, message];
}

class OrderDetail extends Equatable {
  final int id;
  final String branchId;
  final String branchName;
  final String customerId;
  final String description;
  final int status;
  final String createdAt;
  final String orderNo;
  final String shippingAddress;
  final String billingAddress;
  final String shippingPincode;
  final String billingPincode;
  final String billingCountryId;
  final String billingCountryName;
  final String billingStateId;
  final String billingStateName;
  final String billingCityId;
  final String billingCityName;
  final String shippingCountryId;
  final String shippingCountryName;
  final String shippingStateId;
  final String shippingStateName;
  final String shippingCityId;
  final String shippingCityName;
  final String beforeTaxAmount;
  final String totalCgstAmount;
  final String totalSgstAmount;
  final String totalIgstAmount;
  final String grandTotal;
  final String pendingAmount;
  final String receivedAmount;
  final String exclusiveOrInclusive;
  final String customerName;
  final String email;
  final String mobileNo;
  final String whatsappNo;
  final String address;
  final String taxOrNot;
  final List<OrderProduct> orderProductList;
  final String totalMrp;
  final String discountTotal;
  final String newTotalMrp;
  final String cgst;
  final String sgst;
  final String igst;
  final double orderTotal;

  const OrderDetail({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.customerId,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.orderNo,
    required this.shippingAddress,
    required this.billingAddress,
    required this.shippingPincode,
    required this.billingPincode,
    required this.billingCountryId,
    required this.billingCountryName,
    required this.billingStateId,
    required this.billingStateName,
    required this.billingCityId,
    required this.billingCityName,
    required this.shippingCountryId,
    required this.shippingCountryName,
    required this.shippingStateId,
    required this.shippingStateName,
    required this.shippingCityId,
    required this.shippingCityName,
    required this.beforeTaxAmount,
    required this.totalCgstAmount,
    required this.totalSgstAmount,
    required this.totalIgstAmount,
    required this.grandTotal,
    required this.pendingAmount,
    required this.receivedAmount,
    required this.exclusiveOrInclusive,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.whatsappNo,
    required this.address,
    required this.taxOrNot,
    required this.orderProductList,
    required this.totalMrp,
    required this.discountTotal,
    required this.newTotalMrp,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.orderTotal,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: _toInt(json['id']),
      branchId: _toString(json['branch_id']),
      branchName: _toString(json['branch_name']),
      customerId: _toString(json['customer_id']),
      description: _toString(json['description']),
      status: _toInt(json['status']),
      createdAt: _toString(json['created_at']),
      orderNo: _toString(json['order_no']),
      shippingAddress: _toString(json['shipping_address']),
      billingAddress: _toString(json['billing_address']),
      shippingPincode: _toString(json['shipping_pincode']),
      billingPincode: _toString(json['billing_pincode']),
      billingCountryId: _toString(json['billing_country_id']),
      billingCountryName: _toString(json['billing_country_name']),
      billingStateId: _toString(json['billing_state_id']),
      billingStateName: _toString(json['billing_state_name']),
      billingCityId: _toString(json['billing_city_id']),
      billingCityName: _toString(json['billing_city_name']),
      shippingCountryId: _toString(json['shipping_country_id']),
      shippingCountryName: _toString(json['shipping_country_name']),
      shippingStateId: _toString(json['shipping_state_id']),
      shippingStateName: _toString(json['shipping_state_name']),
      shippingCityId: _toString(json['shipping_city_id']),
      shippingCityName: _toString(json['shipping_city_name']),
      beforeTaxAmount: _toString(json['before_tax_amount']),
      totalCgstAmount: _toString(json['total_cgst_amount']),
      totalSgstAmount: _toString(json['total_sgst_amount']),
      totalIgstAmount: _toString(json['total_igst_amount']),
      grandTotal: _toString(json['grand_total']),
      pendingAmount: _toString(json['pending_amount']),
      receivedAmount: _toString(json['received_amount']),
      exclusiveOrInclusive: _toString(json['exclusive_or_inclusive']),
      customerName: _toString(json['customer_name']),
      email: _toString(json['email']),
      mobileNo: _toString(json['mobile_no']),
      whatsappNo: _toString(json['whatsapp_no']),
      address: _toString(json['address']),
      taxOrNot: _toString(json['taxOrNot']),
      orderProductList: (json['orderProductList'] as List? ?? [])
          .map((e) => OrderProduct.fromJson(e))
          .toList(),
      totalMrp: _toString(json['totalMrp']),
      discountTotal: _toString(json['DiscountTotal']),
      newTotalMrp: _toString(json['newTotalMrp']),
      cgst: _toString(json['CGST']),
      sgst: _toString(json['SGST']),
      igst: _toString(json['IGST']),
      orderTotal: _toDouble(json['orderTotal']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'branch_id': branchId,
    'branch_name': branchName,
    'customer_id': customerId,
    'description': description,
    'status': status,
    'created_at': createdAt,
    'order_no': orderNo,
    'shipping_address': shippingAddress,
    'billing_address': billingAddress,
    'shipping_pincode': shippingPincode,
    'billing_pincode': billingPincode,
    'billing_country_id': billingCountryId,
    'billing_country_name': billingCountryName,
    'billing_state_id': billingStateId,
    'billing_state_name': billingStateName,
    'billing_city_id': billingCityId,
    'billing_city_name': billingCityName,
    'shipping_country_id': shippingCountryId,
    'shipping_country_name': shippingCountryName,
    'shipping_state_id': shippingStateId,
    'shipping_state_name': shippingStateName,
    'shipping_city_id': shippingCityId,
    'shipping_city_name': shippingCityName,
    'before_tax_amount': beforeTaxAmount,
    'total_cgst_amount': totalCgstAmount,
    'total_sgst_amount': totalSgstAmount,
    'total_igst_amount': totalIgstAmount,
    'grand_total': grandTotal,
    'pending_amount': pendingAmount,
    'received_amount': receivedAmount,
    'exclusive_or_inclusive': exclusiveOrInclusive,
    'customer_name': customerName,
    'email': email,
    'mobile_no': mobileNo,
    'whatsapp_no': whatsappNo,
    'address': address,
    'taxOrNot': taxOrNot,
    'orderProductList': orderProductList.map((e) => e.toJson()).toList(),
    'totalMrp': totalMrp,
    'DiscountTotal': discountTotal,
    'newTotalMrp': newTotalMrp,
    'CGST': cgst,
    'SGST': sgst,
    'IGST': igst,
    'orderTotal': orderTotal,
  };

  @override
  List<Object?> get props => [
    id,
    branchId,
    branchName,
    customerId,
    description,
    status,
    createdAt,
    orderNo,
    shippingAddress,
    billingAddress,
    shippingPincode,
    billingPincode,
    billingCountryId,
    billingCountryName,
    billingStateId,
    billingStateName,
    billingCityId,
    billingCityName,
    shippingCountryId,
    shippingCountryName,
    shippingStateId,
    shippingStateName,
    shippingCityId,
    shippingCityName,
    beforeTaxAmount,
    totalCgstAmount,
    totalSgstAmount,
    totalIgstAmount,
    grandTotal,
    pendingAmount,
    receivedAmount,
    exclusiveOrInclusive,
    customerName,
    email,
    mobileNo,
    whatsappNo,
    address,
    taxOrNot,
    orderProductList,
    totalMrp,
    discountTotal,
    newTotalMrp,
    cgst,
    sgst,
    igst,
    orderTotal,
  ];
}

class OrderProduct extends Equatable {
  final int id;
  final String stockStatus;
  final String orderId;
  final String customerId;
  final int qty;
  final String price;
  final String totalAmount;
  final String discountType;
  final String discountPer;
  final String discountRs;
  final double newTotalMrp;
  final String cgstId;
  final String cgstRate;
  final String cgstValue;
  final String sgstId;
  final String sgstRate;
  final String sgstValue;
  final String igstId;
  final String igstRate;
  final String igstValue;
  final String totalPrice;
  final String customerName;
  final String email;
  final String mobileNo;
  final String address;
  final String productId;
  final int taxOrNot;
  final String orderProduct;

  const OrderProduct({
    required this.id,
    required this.stockStatus,
    required this.orderId,
    required this.customerId,
    required this.qty,
    required this.price,
    required this.totalAmount,
    required this.discountType,
    required this.discountPer,
    required this.discountRs,
    required this.newTotalMrp,
    required this.cgstId,
    required this.cgstRate,
    required this.cgstValue,
    required this.sgstId,
    required this.sgstRate,
    required this.sgstValue,
    required this.igstId,
    required this.igstRate,
    required this.igstValue,
    required this.totalPrice,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.address,
    required this.productId,
    required this.taxOrNot,
    required this.orderProduct,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: _toInt(json['id']),
      stockStatus: _toString(json['stock_status']),
      orderId: _toString(json['order_id']),
      customerId: _toString(json['customer_id']),
      qty: _toInt(json['qty']),
      price: _toString(json['price']),
      totalAmount: _toString(json['total_amount']),
      discountType: _toString(json['discount_type']),
      discountPer: _toString(json['discount_per']),
      discountRs: _toString(json['discount_rs']),
      newTotalMrp: _toDouble(json['new_total_mrp']),
      cgstId: _toString(json['cgst_id']),
      cgstRate: _toString(json['cgst_rate']),
      cgstValue: _toString(json['cgst_value']),
      sgstId: _toString(json['sgst_id']),
      sgstRate: _toString(json['sgst_rate']),
      sgstValue: _toString(json['sgst_value']),
      igstId: _toString(json['igst_id']),
      igstRate: _toString(json['igst_rate']),
      igstValue: _toString(json['igst_value']),
      totalPrice: _toString(json['total_price']),
      customerName: _toString(json['customer_name']),
      email: _toString(json['email']),
      mobileNo: _toString(json['mobile_no']),
      address: _toString(json['address']),
      productId: _toString(json['product_id']),
      taxOrNot: _toInt(json['taxOrNot']),
      orderProduct: _toString(json['order_product']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'stock_status': stockStatus,
    'order_id': orderId,
    'customer_id': customerId,
    'qty': qty,
    'price': price,
    'total_amount': totalAmount,
    'discount_type': discountType,
    'discount_per': discountPer,
    'discount_rs': discountRs,
    'new_total_mrp': newTotalMrp,
    'cgst_id': cgstId,
    'cgst_rate': cgstRate,
    'cgst_value': cgstValue,
    'sgst_id': sgstId,
    'sgst_rate': sgstRate,
    'sgst_value': sgstValue,
    'igst_id': igstId,
    'igst_rate': igstRate,
    'igst_value': igstValue,
    'total_price': totalPrice,
    'customer_name': customerName,
    'email': email,
    'mobile_no': mobileNo,
    'address': address,
    'product_id': productId,
    'taxOrNot': taxOrNot,
    'order_product': orderProduct,
  };

  @override
  List<Object?> get props => [
    id,
    stockStatus,
    orderId,
    customerId,
    qty,
    price,
    totalAmount,
    discountType,
    discountPer,
    discountRs,
    newTotalMrp,
    cgstId,
    cgstRate,
    cgstValue,
    sgstId,
    sgstRate,
    sgstValue,
    igstId,
    igstRate,
    igstValue,
    totalPrice,
    customerName,
    email,
    mobileNo,
    address,
    productId,
    taxOrNot,
    orderProduct,
  ];
}

String _toString(dynamic v) => v?.toString() ?? '';

int _toInt(dynamic v) =>
    v is int ? v : int.tryParse(v?.toString() ?? '') ?? 0;

double _toDouble(dynamic v) =>
    v is double
        ? v
        : v is int
        ? v.toDouble()
        : double.tryParse(v?.toString() ?? '') ?? 0.0;
