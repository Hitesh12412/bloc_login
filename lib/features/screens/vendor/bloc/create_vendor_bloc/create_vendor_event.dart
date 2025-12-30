abstract class VendorCreateEvent {}

class VendorCreateRequested extends VendorCreateEvent {
  final String userId;
  final String vendorName;
  final String vendorCompanyName;
  final String vendorEmail;
  final String mobileNumber;
  final String whatsappNumber;
  final String gstNumber;
  final String address;
  final String vendorLevelId;
  final String branchId;
  final String productId;



  VendorCreateRequested({
    required this.userId,
    required this.vendorName,
    required this.vendorCompanyName,
    required this.vendorEmail,
    required this.mobileNumber,
    required this.whatsappNumber,
    required this.gstNumber,
    required this.address,
    required this.vendorLevelId,
    required this.branchId,
    required this.productId,
  });
}

