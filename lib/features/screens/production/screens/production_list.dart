import 'package:bloc_login/features/screens/production/bloc/production_list_bloc.dart';
import 'package:bloc_login/features/screens/production/bloc/production_list_event.dart';
import 'package:bloc_login/features/screens/production/bloc/production_list_state.dart';
import 'package:bloc_login/features/screens/production/screens/production_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductionBlocProvider extends StatelessWidget {
  const ProductionBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductionListBloc>(
      create: (context) => ProductionListBloc()
        ..add(
          FetchProductionListEvent(),
        ),
      child: const Production(),
    );
  }
}

class Production extends StatefulWidget {
  const Production({super.key});

  @override
  State<Production> createState() => _ProductionState();
}

class _ProductionState extends State<Production> {
  final Map<int, Map<String, dynamic>> statusMap = {
    2: {
      'name': 'Production',
      'textColor': Colors.yellow.shade900,
      'bgColor': Colors.yellow.shade100,
      'containerColor': Colors.yellow.shade200,
    },
    1: {
      'name': 'Dispatch',
      'textColor': Colors.green.shade900,
      'bgColor': Colors.green.shade100,
      'containerColor': Colors.green.shade100
    },
  };

  @override
  void initState() {
    super.initState();
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
                Icons.local_shipping,
                color: Colors.blue,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Production",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Order Management",
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
      ),
      body: BlocBuilder<ProductionListBloc, ProductionListStates>(
        builder: (context, state) {
          if (state is LoadingProductionListState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedProductionListState) {
            final Productions = state.model.data;
            if (Productions.isEmpty) {
              return _noDataWidget();
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 15, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: const Icon(
                          Icons.reorder_outlined,
                          size: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All Production',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Show All Production Statuses',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          print("Filter button tapped");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.tune,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: Productions.length,
                    itemBuilder: (context, index) {
                      final Production = Productions[index];
                      final statusInfo = statusMap[Production.status] ??
                          {
                            'name': 'Unknown',
                            'textColor': Colors.grey,
                            'bgColor': Colors.grey.shade300,
                            'containerColor': Colors.grey.shade300,
                          };
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductionDetail(orderId: Production.id),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 16,
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: statusInfo['containerColor'],
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        topRight: Radius.circular(14),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          '# ${Production.orderNo}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          Production.statusName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        PopupMenuButton<String>(
                                          itemBuilder: (_) => [
                                            PopupMenuItem<String>(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text('Edit Status'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                      Icons.history,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text('History'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                      Icons.cancel,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text(
                                                    'Cancel Order',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          icon: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  statusInfo['containerColor'],
                                            ),
                                            child: const Icon(
                                              Icons.more_vert,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Customer',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const Text(
                                            "Branch ID",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            Production.email,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text('Branch'),
                                                ],
                                              ),
                                              Text(
                                                Production.branchName,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    child: const Icon(
                                                      Icons.phone_android,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text('Phone'),
                                                ],
                                              ),
                                              Text(
                                                Production.mobileNo,
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade50,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.blue.shade100,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    child: const Icon(
                                                      Icons.receipt_outlined,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    'Billing Address',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                Production.billingAddress,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade50,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.green.shade100,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    child: const Icon(
                                                      Icons
                                                          .local_shipping_outlined,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    'Shipping Address',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                Production.billingAddress,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    height: 1.2,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.0),
                                          Colors.black,
                                          Colors.black.withOpacity(0.0),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.green.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              Production.stockStatus == "0"
                                                  ? 'In Stock'
                                                  : Production.stockStatus,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.blue.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.currency_rupee,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              Production.grandTotal,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is FailureProductionListState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is InternalServerErrorProductionListState) {
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
