import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_bloc.dart';
import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_event.dart';
import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_state.dart';
import 'package:bloc_login/features/screens/purchase/screens/purchase_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class PurchaseBlocProvider extends StatelessWidget {
  const PurchaseBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PurchaseListBloc>(
      create: (context) => PurchaseListBloc()
        ..add(
          FetchPurchaseListEvent(),
        ),
      child: const Purchase(),
    );
  }
}

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  final Map<int, Map<String, dynamic>> statusMap = {
    2: {
      'name': 'Approved',
      'textColor': const Color(0xFF2E7D32),
      'bgColor': const Color(0xFFE8F5E8),
    },
    1: {
      'name': 'Vendor Confirmed',
      'textColor': const Color(0xFF1976D2),
      'bgColor': const Color(0xFFE3F2FD),
    },
    0: {
      'name': 'Pending',
      'textColor': const Color(0xFFF57C00),
      'bgColor': const Color(0xFFFFF3E0),
    },
    3: {
      'name': 'Cancelled',
      'textColor': const Color(0xFFD32F2F),
      'bgColor': const Color(0xFFFFEBEE),
    },
  };

  @override
  void initState() {
    super.initState();
  }

  String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.note_outlined,
                color: Colors.blue,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Purchase Requisition",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Purchase requisition Management",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              //
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.blue,
              ),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: BlocBuilder<PurchaseListBloc, PurchaseListStates>(
        builder: (context, state) {
          if (state is LoadingPurchaseListState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedPurchaseListState) {
            final purchases = state.model.data;
            if (purchases.isEmpty) {
              return _noDataWidget();
            }
            return ListView.builder(
              itemCount: purchases.length,
              itemBuilder: (context, index) {
                final purchase = purchases[index];
                String currentDate = formatDate(purchase.createdAt);
                bool isFirstInGroup = index == 0 ||
                    formatDate(purchases[index - 1].createdAt) != currentDate;
                final statusInfo = statusMap[purchase.status] ??
                    {
                      'name': 'Unknown',
                      'textColor': Colors.grey,
                      'bgColor': Colors.grey.shade300,
                    };
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PurchaseListDetails(
                     PurchaseData: purchase,
                    ),),);
                  },
                  child: StickyHeader(
                    header: isFirstInGroup
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade800,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.today,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(currentDate),
                            ],
                          ),
                        ),
                      ],
                    )
                        : const SizedBox.shrink(),
                    content: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade100,
                                  Colors.blue.shade300,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.inventory_2_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        purchase.productName,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1976D2),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusInfo['bgColor'],
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              size: 16,
                                              color: statusInfo['textColor'],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              statusInfo['name'],
                                              style: TextStyle(
                                                color: statusInfo['textColor'],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                PopupMenuButton<String>(
                                  itemBuilder: (_) => [
                                    PopupMenuItem<String>(
                                      value: "Edit",
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color:
                                              Colors.blue.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: const Icon(Icons.edit,
                                                color: Colors.blue),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Edit'),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: "history",
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color:
                                              Colors.blue.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: const Icon(Icons.history,
                                                color: Colors.blue),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('History'),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: "delete",
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color:
                                              Colors.red.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: const Icon(Icons.delete_outline,
                                                color: Colors.red),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Delete'),
                                        ],
                                      ),
                                    ),
                                  ],
                                  icon: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.more_vert,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDetailItem(
                                        valueColor: Colors.blue,
                                        icon: Icons.receipt_outlined,
                                        title: 'Purchase No.',
                                        value: purchase.purchaseNo,
                                        iconColor: const Color(0xFF1976D2),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDetailItem(
                                        valueColor: Colors.blue,
                                        icon: Icons.confirmation_number_outlined,
                                        title: 'Order No.',
                                        value: purchase.orderNo.isNotEmpty
                                            ? purchase.orderNo
                                            : 'N/A',
                                        iconColor: const Color(0xFF1976D2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDetailItem(
                                        valueColor: Colors.black,
                                        icon: Icons.inventory_outlined,
                                        title: 'Quantity',
                                        value: purchase.qty,
                                        iconColor: const Color(0xFF1976D2),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDetailItem(
                                        valueColor: Colors.black,
                                        icon: Icons.local_shipping_outlined,
                                        title: 'Delivery Date',
                                        value: formatDate(purchase.deliverDate),
                                        iconColor: const Color(0xFF1976D2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildDetailItem(
                                  valueColor: Colors.black,
                                  icon: Icons.payment_outlined,
                                  title: 'Payment Terms',
                                  value: purchase.paymentTerm,
                                  iconColor: const Color(0xFF1976D2),
                                  isFullWidth: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                );
              },
            );
          } else if (state is FailurePurchaseListState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is InternalServerErrorPurchaseListState) {
            return Center(
              child: Text(state.error),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required Color valueColor,
    required Color iconColor,
    bool isFullWidth = false,
  }) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _noDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://cdni.iconscout.com/illustration/premium/thumb/no-data-found-illustration-download-in-svg-png-gif-file-formats--office-computer-digital-work-business-pack-illustrations-7265556.png',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text("Data Not Found!"),
        ],
      ),
    );
  }
}
