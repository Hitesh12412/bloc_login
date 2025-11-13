import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_bloc.dart';
import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_event.dart';
import 'package:bloc_login/features/screens/purchase/bloc/purchase_product_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReturnRequest extends StatelessWidget {
  const ReturnRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PurchaseListBloc>(
      create: (context) => PurchaseListBloc()
        ..add(
          FetchPurchaseListEvent(),
        ),
      child: const ReturnRequestView(),
    );
  }
}

class ReturnRequestView extends StatefulWidget {
  const ReturnRequestView({super.key});


  @override
  State<ReturnRequestView> createState() => _ReturnRequestViewState();
}

class _ReturnRequestViewState extends State<ReturnRequestView> {

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
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        titleSpacing: 0,
        title: const Row(
          children: [
            Text(
              "Goods Return Request",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<PurchaseListBloc, PurchaseListStates>(
        builder: (context, state) {
          if (state is LoadingPurchaseListState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedPurchaseListState) {
            final purchases = state.model.data;
            final totalCount = state.model.totalCount;

            if (purchases.isEmpty) {
              return _noDataWidget();
            }
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade50,
                        Colors.blue.shade100,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.receipt_long_outlined,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total Return Orders: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '$totalCount',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const Text("Goods Return Request",style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16,top: 10),
                    itemCount: purchases.length,
                    itemBuilder: (context, index) {
                      final purchase = purchases[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
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
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade50,
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
                                      Icons.shopping_bag_outlined,
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
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1976D2),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade200,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '#${purchase.orderNo}',
                                            style: const TextStyle(color: Colors.blue),
                                          ),)
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
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
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.receipt_long,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Order No.',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        purchase.orderNo,
                                        style: const TextStyle(color: Colors.green),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.orange.shade300)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.checklist_sharp,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Quantity',
                                              style: TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        Text(
                                          purchase.qty,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.green.shade300)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.wallet_outlined,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Payment Term',
                                              style: TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        Text(
                                          purchase.paymentTerm,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            if(purchase.description.isNotEmpty)
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.list_alt_sharp,color: Colors.purple,),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Description',style: TextStyle(color: Colors.grey),),
                                    Text(purchase.description)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
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

