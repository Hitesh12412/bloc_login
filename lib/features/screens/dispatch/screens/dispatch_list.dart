import 'package:bloc_login/features/screens/dispatch/bloc/dispatch_list_bloc.dart';
import 'package:bloc_login/features/screens/dispatch/bloc/dispatch_list_event.dart';
import 'package:bloc_login/features/screens/dispatch/bloc/dispatch_list_state.dart';
import 'package:bloc_login/features/screens/production/screens/production_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DispatchBlocProvider extends StatelessWidget {
  const DispatchBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DispatchListBloc>(
      create: (context) => DispatchListBloc()
        ..add(
          FetchDispatchListEvent(),
        ),
      child: const Dispatch(),
    );
  }
}

class Dispatch extends StatefulWidget {
  const Dispatch({super.key});

  @override
  State<Dispatch> createState() => _DispatchState();
}

class _DispatchState extends State<Dispatch> {
  final Map<int, Map<String, dynamic>> statusMap = {
  3: {
  'name': 'Order Dispatched',
  'textColor': Colors.blue.shade900,
  'bgColor': Colors.blue.shade100,
  'containerColor': Colors.blue.shade100
  },
  6: {
  'name': 'Order Completed',
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
                Icons.fire_truck_sharp,
                color: Colors.blue,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dispatch",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Dispatch Management",
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
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 15,top: 10),
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
                      Icons.format_align_left_outlined,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Dispatch',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Show All Dispatch Statues',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
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
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProductionDetail(orderId: 63,)));
                },
                child: BlocBuilder<DispatchListBloc, DispatchListStates>(
                  builder: (context, state) {
                    if (state is LoadingDispatchListState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoadedDispatchListState) {
                      final Dispatchs = state.model.data;
                        if (Dispatchs.isEmpty) {
                          return _noDataWidget();
                        }
                        return ListView.builder(
                          itemCount: Dispatchs.length,
                          itemBuilder: (context, index) {
                            final Dispatch = Dispatchs[index];
                            final statusInfo = statusMap[Dispatch.status] ?? {
                              'name': 'Unknown',
                              'textColor': Colors.grey,
                              'bgColor': Colors.grey.shade300,
                              'containerColor': Colors.grey.shade300,
                            };
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 16, left: 10, right: 10),
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
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                          color: statusInfo['containerColor'],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(14),
                                            topRight: Radius.circular(14),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '# ${Dispatch.orderNo}',
                                              style: TextStyle(
                                                color: statusInfo['textColor'],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Text(
                                                  statusInfo['name'],
                                                  style: TextStyle(
                                                    color:
                                                        statusInfo['textColor'],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                PopupMenuButton<String>(
                                                  itemBuilder: (_) => [
                                                    PopupMenuItem<String>(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.blue
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .book_online_outlined,
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          const Text('Quotation'),
                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuItem<String>(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .delete_outline,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          const Text('Delete'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: statusInfo['textColor']
                                                        as Color,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade100,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const Icon(Icons.person,color: Colors.blue,),),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Customer',style: TextStyle(color: Colors.grey),),
                                                Text(Dispatch.customerName,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                                                Text(Dispatch.email,style: const TextStyle(color: Colors.grey),),
                                              ],
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
                                                left: 10,
                                                right: 10,
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                border: Border.all(
                                                  color: Colors.grey.shade400,
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
                                                          Icons.location_on_outlined,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text('Branch'),
                                                    ],
                                                  ),
                                                  Text(
                                                    Dispatch.branchName,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                border: Border.all(
                                                  color: Colors.grey.shade400,
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
                                                          Icons.mobile_friendly_sharp,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text('Phone'),
                                                    ],
                                                  ),
                                                  Text(
                                                    Dispatch.mobileNo,
                                                    style: const TextStyle(
                                                      color: Colors.blue,
                                                      textBaseline:
                                                          TextBaseline.alphabetic,
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
                                          Expanded(child: Container(
                                            margin: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius:
                                              BorderRadius.circular(14),
                                              border: Border.all(
                                                color: Colors.blue.shade200,
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
                                                        Icons.file_copy_outlined,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    const Text('Billing Address',style: TextStyle(color: Colors.blue),),
                                                  ],
                                                ),
                                                Text(
                                                  Dispatch.billingAddress,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    textBaseline:
                                                    TextBaseline.alphabetic,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade100,
                                                borderRadius:
                                                BorderRadius.circular(14),
                                                border: Border.all(
                                                  color: Colors.green.shade300,
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
                                                          Icons.bus_alert_rounded,
                                                          color:
                                                          Colors.green,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text('Assigned To',style: TextStyle(color: Colors.green),),
                                                    ],
                                                  ),
                                                  Text(
                                                    Dispatch.customerName,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Container(
                                        height: 1.2,
                                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                      Row(
                                        children: [
                                          Dispatch.pendingAmount.trim().isEmpty || Dispatch.pendingAmount == '0'
                                              ? Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(14),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.green.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Complete',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : PendingAmountFlip(pendingAmount: Dispatch.pendingAmount),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(14),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.blue.withOpacity(0.5),
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
                                                  Dispatch.grandTotal,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                     else if (state is FailureDispatchListState) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is InternalServerErrorDispatchListState) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
          const SizedBox(
            height: 16,
          ),
          const Text("Data Not Found!"),
        ],
      ),
    );
  }
}

class PendingAmountFlip extends StatefulWidget {
  final String pendingAmount;

  const PendingAmountFlip({required this.pendingAmount, super.key});

  @override
  _PendingAmountFlipState createState() => _PendingAmountFlipState();
}

class _PendingAmountFlipState extends State<PendingAmountFlip>
    with SingleTickerProviderStateMixin {
  bool _showPendingAmount = false;
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleFlip() {
    if (_showPendingAmount) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _showPendingAmount = !_showPendingAmount;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _frontWidget() {
    return GestureDetector(
      onTap: _toggleFlip,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Text(
              "Pending",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.refresh, color: Colors.white, size: 20),),
          ],
        ),
      ),
    );
  }

  Widget _backWidget() {
    return GestureDetector(
      onTap: _toggleFlip,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.currency_rupee, color: Colors.white, size: 20),
            Text(
              widget.pendingAmount,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) {
        final isHalfWay = _flipAnimation.value > 0.5;
        final displayWidget = isHalfWay ? _backWidget() : _frontWidget();
        final rotationY = isHalfWay ? (_flipAnimation.value - 1) * 3.14159 : _flipAnimation.value * 3.14159;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(rotationY),
          alignment: Alignment.center,
          child: displayWidget,
        );
      },
    );
  }
}
