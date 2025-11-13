import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/order_list/order_list_bloc.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/order_list/order_list_event.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/order_list/order_list_state.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order_paymnet_history_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentHistory extends StatelessWidget {
  const OrderPaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()..add(const FetchOrderEvent(userId: '1',)),
      child: const OrderScreenView(),
    );
  }
}

class OrderScreenView extends StatefulWidget {
  const OrderScreenView({super.key});

  @override
  State<OrderScreenView> createState() => _OrderScreenViewState();
}

class _OrderScreenViewState extends State<OrderScreenView> {
  DateTime _startDate = DateTime(2025, 7, 1);
  DateTime _endDate = DateTime(2025, 7, 7);

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _endDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.payments_outlined,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment History',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Order payment history',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              // Add search functionality
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.blue,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Add search functionality
            },
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                )),
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),),
      ),
      body: BlocBuilder<OrderBloc, OrderStates>(
        builder: (context, state) {
          if (state is LoadingOrderState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedOrderState) {
            final Orders = state.model.data;
            if (Orders.isEmpty) {
              return _noDataWidget();
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.blue.withOpacity(0.7)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Filter by Date Range",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _dateBox(_startDate, _pickStartDate),
                            ),
                            const SizedBox(width: 8),
                            _arrowCircle(),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _dateBox(_endDate, _pickEndDate),
                            ),
                          ],
                        ),
                        _confirmCircle(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade500,
                                Colors.green.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.trending_up,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Given Payment',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const Text(
                                'GP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.shade500,
                                Colors.red.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.red,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.trending_down,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Outstanding',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              const Text(
                                'OP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...Orders.map((Order) => GestureDetector(
                    onTap: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OrderPaymentHistoryDetails(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 8,
                                          bottom: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        Order.customerName.isNotEmpty
                                            ? Order.customerName[0]
                                            .toUpperCase()
                                            : 'C',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              Order.customerName,
                                              style: const TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 18),
                                              overflow:
                                              TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            color: Colors.blue,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            Order.mobileNo.isNotEmpty
                                                ? Order.mobileNo
                                                : 'No phone',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                              TextDecoration.underline,
                                              decorationColor: Colors.blue,
                                              fontSize: 15,
                                              height: 1.5,
                                              decorationThickness: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'Total Amount',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 18,
                                      ),
                                      Text(
                                        Order.grandTotal,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Given',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 18,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        Order.receivedAmount,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'OutStanding',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        Order.pendingAmount,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  )),
                  const SizedBox(height: 32),
                ],
              ),
            );
          } else if (state is FailureOrderState ||
              state is InternalServerErrorOrderState) {
            final errorMsg = state is FailureOrderState
                ? state.error
                : (state as InternalServerErrorOrderState).error;
            return Center(child: Text(errorMsg));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
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

Widget _dateBox(DateTime date, VoidCallback onTap) => InkWell(
  onTap: onTap,
  child: Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey),
      boxShadow: const [
        BoxShadow(
            color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today_rounded,
            size: 20,
            color: Colors.blue,
          ),
          const SizedBox(width: 15),
          Text(
            "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  ),
);

Widget _arrowCircle() => Container(
  padding: const EdgeInsets.all(6),
  decoration: BoxDecoration(
    color: Colors.blue.withOpacity(0.2),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
    ],
  ),
  child: const Icon(Icons.compare_arrows, color: Colors.blue),
);

Widget _confirmCircle() => Container(
  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
    ],
  ),
  child: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.filter_alt_outlined, color: Colors.white),
      SizedBox(width: 6),
      Text(
        'Apply Filter',
        style: TextStyle(color: Colors.white, fontSize: 16),
      )
    ],
  ),
);
