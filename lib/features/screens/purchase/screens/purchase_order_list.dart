import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_bloc.dart';
import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_event.dart';
import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class PurchaseOrderList extends StatelessWidget {
  const PurchaseOrderList({super.key});

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
                Icons.shopping_cart_outlined,
                color: Colors.blue,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Purchase Order",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Vendor and inventory Purchase",
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
                return StickyHeader(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
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
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.inventory_2_outlined,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      purchase.productName,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),const Spacer(),
                              PopupMenuButton<String>(
                                itemBuilder: (_) => [
                                  PopupMenuItem<String>(
                                    value: "copy",
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
                                        const Text('View History'),
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
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow(
                                colorValue: Colors.black,
                                icon: CupertinoIcons.building_2_fill,
                                iconColor: Colors.blue,
                                title: 'Vendor',
                                value: 'Vendor Name',
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoRow(
                                      colorValue: Colors.black,
                                      icon: Icons.email_outlined,
                                      iconColor: Colors.orange,
                                      title: 'Email',
                                      value: 'v@gmail.com',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildInfoRow(
                                      colorValue: Colors.blue,
                                      icon: Icons.phone,
                                      iconColor: Colors.green,
                                      title: 'Mobile',
                                      value: '8140211211',
                                      isClickable: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoRow(
                                      colorValue: Colors.black,
                                      icon: Icons.inventory_outlined,
                                      iconColor: Colors.purple,
                                      title: 'Quantity',
                                      value: purchase.qty,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildInfoRow(
                                      colorValue: Colors.black,
                                      icon: Icons.payment_outlined,
                                      iconColor: Colors.red,
                                      title: 'Payment Terms',
                                      value: purchase.paymentTerm,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow(
                                colorValue: Colors.black,
                                icon: Icons.local_shipping_outlined,
                                iconColor: Colors.blue,
                                title: 'Delivery Date',
                                value: formatDate(purchase.deliverDate),
                              ),
                              const SizedBox(height: 16),

                              _buildInfoRow(
                                colorValue: Colors.black,
                                icon: Icons.location_on_outlined,
                                iconColor: Colors.teal,
                                title: 'Address',
                                value: 'Address Location',
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow(
                                colorValue: Colors.black,
                                icon: Icons.description_outlined,
                                iconColor: Colors.brown,
                                title: 'Description',
                                value: purchase.description.isNotEmpty
                                    ? purchase.description
                                    : 'No description available',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required Color colorValue,
    bool isClickable = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon,color: iconColor,),
              const SizedBox(width: 8),
              Text(title,style: const TextStyle(color: Colors.grey),),
            ],
          ),
          const SizedBox(height: 4),
          Text(value,style: TextStyle(color: colorValue),)
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
