import 'package:bloc_login/features/screens/dispatch/screens/dispatch_list_details.dart';
import 'package:bloc_login/features/screens/lead/bloc/lead_list/lead_list_bloc.dart';
import 'package:bloc_login/features/screens/lead/bloc/lead_list/lead_list_event.dart';
import 'package:bloc_login/features/screens/lead/bloc/lead_list/lead_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeadBlocProvider extends StatelessWidget {
  const LeadBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeadListBloc>(
      create: (context) => LeadListBloc()
        ..add(
          FetchLeadListEvent(),
        ),
      child: const Lead(),
    );
  }
}

class Lead extends StatefulWidget {
  const Lead({super.key});

  @override
  State<Lead> createState() => _LeadState();
}

class _LeadState extends State<Lead> {
  int selectedIndex = 0;
  int selectedDayIndex = 0;

  List<DateTime> getRemainingDaysOfMonth() {
    final now = DateTime.now();
    final lastDay = DateTime(now.year, now.month + 1, 0).day;
    return List.generate(
      lastDay - now.day + 1,
      (index) => DateTime(now.year, now.month, now.day + index),
    );
  }

  final Map<String, Map<String, dynamic>> statusMap = {
    '1': {
      'name': 'Pending',
      'textColor': Colors.orange.shade900,
      'bgColor': Colors.orange.shade100,
      'containerColor': Colors.orange.shade100
    },
    '2': {
      'name': 'Confirmed',
      'textColor': Colors.green.shade900,
      'bgColor': Colors.green.shade100,
      'containerColor': Colors.green.shade100
    },
    '3': {
      'name': 'In Progress',
      'textColor': Colors.green.shade900,
      'bgColor': Colors.green.shade100,
      'containerColor': Colors.green.shade100
    },
    '4': {
      'name': 'Rejected',
      'textColor': Colors.red.shade900,
      'bgColor': Colors.red.shade100,
      'containerColor': Colors.red.shade100
    },
    '5': {
      'name': 'Schedule',
      'textColor': Colors.blue.shade900,
      'bgColor': Colors.blue.shade100,
      'containerColor': Colors.blue.shade100
    },
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final upcomingDays = getRemainingDaysOfMonth();

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
                Icons.fact_check_outlined,
                color: Colors.blue,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lead",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Lead Management",
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
                Icons.more_vert,
                color: Colors.black,
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
              child: _buildToggleTabs(context),
            ),
            if (selectedIndex == 0)
              Container(
                padding: const EdgeInsets.all(10),
                margin:
                    const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                          'All Lead',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Show All Lead Statues',
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<LeadListBloc, LeadListStates>(
                builder: (context, state) {
                  if (state is LoadingLeadListState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedLeadListState) {
                    final leads = state.model.data;
                    if (selectedIndex == 0) {
                      if (leads.isEmpty) {
                        return _noDataWidget();
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductionDetail(orderId: 63,),
                            ),
                          );
                        },
                        child: ListView.builder(
                          itemCount: leads.length,
                          itemBuilder: (context, index) {
                            final lead = leads[index];
                            final statusInfo = statusMap[lead.status] ??
                                {
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
                                              '# ${lead.leadNo}',
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
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          lead.leadName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Text(
                                          lead.customerName,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
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
                                                        padding:
                                                            const EdgeInsets.all(
                                                                3),
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .orange.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: const Icon(
                                                          Icons.location_pin,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text('Branch'),
                                                    ],
                                                  ),
                                                  Text(
                                                    lead.branchName,
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
                                                        padding:
                                                            const EdgeInsets.all(
                                                                3),
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .green.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: const Icon(
                                                          Icons.phone,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text('Phone'),
                                                    ],
                                                  ),
                                                  Text(
                                                    lead.mobileNo,
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
                                          Expanded(
                                            flex: (lead.employeeName.isNotEmpty &&
                                                    lead.employeeName != '0')
                                                ? 1
                                                : 2,
                                            child: Container(
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
                                                        padding:
                                                            const EdgeInsets.all(
                                                                3),
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .purple.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: const Icon(
                                                          Icons.home,
                                                          color: Colors.purple,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text('Billing Address'),
                                                    ],
                                                  ),
                                                  Text(
                                                    lead.billingAddress,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      textBaseline:
                                                          TextBaseline.alphabetic,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (lead.employeeName.isNotEmpty &&
                                              lead.employeeName != '0')
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10, right: 10),
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
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .deepPurple
                                                                .shade100,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                          ),
                                                          child: const Icon(
                                                            Icons.person,
                                                            color:
                                                                Colors.deepPurple,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        const Text('Assigned To'),
                                                      ],
                                                    ),
                                                    Text(
                                                      lead.employeeName,
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
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Total Amount',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.currency_rupee,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                      lead.grandTotal,
                                                      style: const TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              child: const Icon(
                                                Icons.currency_rupee,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return _upcomingTabWidget(upcomingDays);
                    }
                  } else if (state is FailureLeadListState) {
                    return Center(
                      child: Text('Error: ${state.error}'),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
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

  Widget _upcomingTabWidget(List<DateTime> upcomingDays) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: upcomingDays.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final date = upcomingDays[index];
              final isSelected = selectedDayIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedDayIndex = index;
                    },
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 45,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${date.day}',
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            [
                              'Sun',
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat'
                            ][date.weekday % 7],
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 300),
        Center(
          child: Container(
            child: Column(
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
          ),
        )
      ],
    );
  }

  Widget _buildToggleTabs(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            alignment: selectedIndex == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 32,
              margin: const EdgeInsets.all(
                4,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        selectedIndex = 0;
                      },
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'All',
                      style: TextStyle(
                        color:
                            selectedIndex == 0 ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        selectedIndex = 1;
                      },
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Upcoming Schedule',
                      style: TextStyle(
                        color:
                            selectedIndex == 1 ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
