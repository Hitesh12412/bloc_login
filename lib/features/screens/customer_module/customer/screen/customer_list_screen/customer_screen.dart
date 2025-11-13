import 'package:bloc_login/features/screens/customer_module/customer/bloc/customer_list/customer_list_bloc.dart';
import 'package:bloc_login/features/screens/customer_module/customer/bloc/customer_list/customer_list_event.dart';
import 'package:bloc_login/features/screens/customer_module/customer/bloc/customer_list/customer_list_state.dart';
import 'package:bloc_login/features/screens/customer_module/ui/addcustomer.dart';
import 'package:bloc_login/features/screens/customer_module/ui/customer_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerListBloc>(
      create: (context) => CustomerListBloc()
        ..add(
          FetchCustomerListEvent(),
        ),
      child: const CustomerScreen(),
    );
  }
}

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CustomerListBloc>().add(FetchCustomerListEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.dashboard_rounded, size: 36, color: Colors.white),
        ),
        centerTitle: true,
        title: const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg?semt=ais_hybrid&w=740",
          ),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.notifications, size: 28, color: Colors.black)),
          const SizedBox(width: 10),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.person_2_rounded,
              size: 28,
              color: Colors.black,
            ),)
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CustomerListBloc, CustomerListStates>(
          builder: (context, state) {
            if (state is InitialCustomerListState || (state is LoadedCustomerListState && state.model.data.isEmpty)) {
              return _noDataWidget();
            }
            if (state is LoadedCustomerListState) {
              final customers = state.model.data;

              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text('Manage your customers')
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.filter_alt_rounded)),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Addcustomer()));
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildAddCustomerButton(customers.length),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.model.hasNextPage
                          ? customers.length + 1
                          : customers.length,
                      itemBuilder: (context, index) {
                        if (index >= customers.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final customer = customers[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerDetailScreen(
                                    customer: customer,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Card(
                              elevation: 2,
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
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
                                                customer.customerName.isNotEmpty
                                                    ? customer.customerName[0]
                                                        .toUpperCase()
                                                    : 'C',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                      customer.customerName,
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
                                              Text(
                                                customer.email.isNotEmpty
                                                    ? customer.email
                                                    : 'No email provided',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
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
                                                        Icons
                                                            .check_circle_outline,
                                                        color: Colors.blue),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text('Select'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '${customer.customerName} Deleted Successfully !',
                                                    ),
                                                  ),
                                                );
                                              },
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
                                                        Icons.delete_outline,
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
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color:
                                                      Colors.orange.shade100),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 2),
                                                )
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.more_vert,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(15),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              color: Colors.blue,
                                              size: 15,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              customer.mobileNo.isNotEmpty
                                                  ? customer.mobileNo
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
                                        const Spacer(),
                                        if (customer.customerLevelName.isNotEmpty)
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 2,
                                              bottom: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.blue.shade300),
                                            ),
                                            child: Text(
                                              customer.customerLevelName,
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is FailureCustomerListState) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is InternalServerErrorCustomerListState) {
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

  Widget _buildAddCustomerButton(int currentCount) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_2_outlined,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Customer',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              Text(
                '$currentCount',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
