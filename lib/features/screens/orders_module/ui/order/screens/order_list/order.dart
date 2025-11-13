import 'package:bloc_login/features/screens/dispatch/screens/dispatch_list_details.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/order_list/order_list_bloc.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/order_list/order_list_event.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/order_list/order_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class CreateOderScreen extends StatefulWidget {
  final String userId;
  const CreateOderScreen({super.key, required this.userId});
  @override
  State<CreateOderScreen> createState() => _CreateOderScreenState();
}

class _CreateOderScreenState extends State<CreateOderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderBloc()..add(FetchOrderEvent(userId: widget.userId)),
      child: const OrderListScreenWidget(),
    );
  }
}

class OrderListScreenWidget extends StatefulWidget {
  const OrderListScreenWidget({super.key});

  @override
  State<OrderListScreenWidget> createState() => _OrderListScreenWidgetState();
}

class _OrderListScreenWidgetState extends State<OrderListScreenWidget> {
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  Color _hexToColor(String hex) {
    try {
      hex = hex.replaceAll("#", "");
      if (hex.length == 6) {
        hex = "FF$hex";
      }
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderBloc>(context).add(const FetchOrderEvent(userId: "1"));
  }

  String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('MMM,dd yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: !_showSearchBar
            ? Row(
          children: [
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.description_outlined, color: Colors.blue),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Order Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        )
            : Container(
          margin: const EdgeInsets.only(right: 10, left: 10, top: 6, bottom: 6),
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search by Customer Name',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.blue),
              suffixIcon: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.grey, size: 20),
                ),
                onPressed: () {
                  setState(() {
                    _showSearchBar = false;
                    _searchController.clear();
                  });
                  context.read<OrderBloc>().add(const FetchOrderEvent(userId: "1"));
                },
              ),
            ),
            style: const TextStyle(color: Colors.black, fontSize: 15),
            onChanged: (value) {
              context.read<OrderBloc>().add(FetchOrderEvent(userId: "1", searchText: value));
            },
          ),
        ),
        actions: [
          if (!_showSearchBar)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showSearchBar = true;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.search, size: 25, color: Colors.black),
              ),
            ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.add, size: 25, color: Colors.black),
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      height: 300,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),),
                    );},);
            },
            child: Container(
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
                      Icons.format_align_left_outlined,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Orders',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Show All Order Statuses',
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
          ),
          Expanded(
            child: BlocBuilder<OrderBloc, OrderStates>(
              builder: (context, state) {
                if (state is LoadingOrderState) {
                  return const Center(child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ));
                } else if (state is LoadedOrderState) {
                  final orders = state.model.data;
                  if (orders.isNotEmpty) {
                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        String currentDate = formatDate(order.createdAt);
                        bool isFirstInGroup = index == 0 ||
                            formatDate(orders[index - 1].createdAt) != currentDate;
                        final Color statusTextColor =
                            _hexToColor(order.statusTextColor);
                        final Color statusBgColor = _hexToColor(order.statusBgcolor);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProductionDetail(orderId: 000159),
                              ),
                            );
                          },
                          child: StickyHeader(
                            header: isFirstInGroup
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(15),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 5, bottom: 5),
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: statusBgColor.withOpacity(0.6),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "# ${order.orderNo}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: statusTextColor),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: statusBgColor.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            order.statusName,
                                            style: TextStyle(
                                              color: statusTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          itemBuilder: (_) => [
                                            PopupMenuItem<String>(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.2),
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
                                              onTap: () {},
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
                                                    child: const Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text('Delete'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.2),
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
                                          ],
                                          icon: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: statusBgColor.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: statusBgColor.withOpacity(0.3),
                                              ),
                                            ),
                                            child: Icon(Icons.more_vert,
                                                color: statusTextColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Icon(Icons.person,
                                            color: Colors.blue),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Customer",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            order.customerName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            order.email,
                                            style:
                                                const TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(0.4),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(Icons.location_on_outlined,
                                                      color: Colors.blue),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Branch',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Text(order.branchName),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(0.4),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(Icons.phone_android,
                                                      color: Colors.blue),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Phone',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                order.mobileNo,
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor: Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: Colors.blue.withOpacity(0.4),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(Icons.contact_page_outlined,
                                                      color: Colors.blue),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Billing Address',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                order.billingAddress,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: Colors.green.withOpacity(0.4),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(Icons.local_shipping_outlined,
                                                      color: Colors.green),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Shipping Address',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                order.shippingAddress,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    height: 1.5,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.grey,
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      if (order.statusName == 'Order Cancel')
                                        const SizedBox.shrink(),
                                      if (order.statusName == 'Pending')
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.red.shade300,
                                                  Colors.red.shade600,
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight),
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.red.withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(Icons.cancel_outlined,
                                                  color: Colors.white),
                                              SizedBox(width: 5),
                                              Text(
                                                'Out of Stock',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (order.statusName == 'Production')
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.green.shade300,
                                                  Colors.green.shade600,
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight),
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.green.withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(Icons.check_circle,
                                                  color: Colors.white),
                                              SizedBox(width: 5),
                                              Text(
                                                'In Stock',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.currency_rupee,
                                                color: Colors.white, size: 20),
                                            Text(
                                              order.pendingAmount,
                                              style: const TextStyle(
                                                  color: Colors.white, fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
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
                          const Text("Data Not Found!"),
                        ],
                      ),
                    );
                  }
                } else if (state is FailureOrderState) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is InternalServerErrorOrderState) {
                  return Center(child: Text(state.error));
                } else if (state is ServerErrorOrderState) {
                  return Center(child: Text(state.error));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
