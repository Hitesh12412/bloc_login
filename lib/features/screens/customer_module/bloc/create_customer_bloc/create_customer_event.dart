import 'package:equatable/equatable.dart';

abstract class CustomerCreateEvent extends Equatable {
  const CustomerCreateEvent();

  @override
  List<Object> get props => [];
}

class CustomerCreateRequested extends CustomerCreateEvent {
  final String dbConnection;
  final String customerName;
  final String email;
  final String mobileNo;
  final String? whatsappNo;
  final String? gstNo;
  final String address;
  final String userId;
  final String customerLevelId;
  final String productId;

  const CustomerCreateRequested({
    required this.dbConnection,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    this.whatsappNo,
    this.gstNo,
    required this.address,
    required this.userId,
    required this.customerLevelId,
    required this.productId,
  });

  @override
  List<Object> get props => [
        dbConnection,
        customerName,
        email,
        mobileNo,
        if (whatsappNo != null) whatsappNo!,
        if (gstNo != null) gstNo!,
        address,
        userId,
        customerLevelId,
        productId,
      ];
}
