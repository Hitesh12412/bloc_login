import 'package:bloc_login/features/screens/support/screens/support_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/features/screens/support/bloc/support_screen_bloc.dart';
import 'package:bloc_login/features/screens/support/bloc/support_screen_event.dart';
import 'package:bloc_login/features/screens/support/bloc/support_screen_state.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SupportBlocProvider extends StatefulWidget {
  const SupportBlocProvider({super.key});

  @override
  State<SupportBlocProvider> createState() => _SupportBlocProviderState();
}

class _SupportBlocProviderState extends State<SupportBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SupportListBloc>(
      create: (context) => SupportListBloc()
        ..add(
          FetchSupportListEvent(),
        ),
      child: const Support(),
    );
  }
}


class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

String formatDate(String dateString) {
  try {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM,dd yyyy').format(date);
  } catch (e) {
    return dateString;
  }
}

class _SupportState extends State<Support> {

  final Map<int, Map<String, dynamic>> statusMap = {
    1: {
      'name': 'Pending',
      'textColor': Colors.orange.shade900,
      'bgColor': Colors.orange.shade100,
      'containerColor': Colors.orange.shade100,
    },
    4: {
      'name': 'Done',
      'textColor': Colors.green.shade900,
      'bgColor': Colors.green.shade100,
      'containerColor': Colors.green.shade100
    },
  };

  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
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
        title: !_showSearchBar
          ?
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.support_agent,
                color: Colors.blue,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Support",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Support Management",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
              hintText: 'Search by Module Name',
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
                  context.read<SupportListBloc>().add(FetchSupportListEvent());
                },
              ),
            ),
            style: const TextStyle(color: Colors.black, fontSize: 15),
            onChanged: (value) {
              context.read<SupportListBloc>().add(FetchSupportListEvent());
            },
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
        ],
        centerTitle: false,
      ),
      body: Column(
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
                    Icons.format_align_left_outlined,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Support',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Show All Support Statuses',
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
            child: BlocBuilder<SupportListBloc, SupportListStates>(
              builder: (context, state) {
                if (state is LoadingSupportListState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedSupportListState) {
                  final supports = state.model.data.supportListData;
                  if (supports.isEmpty) {
                    return _noDataWidget();
                  }
                  return ListView.builder(
                    itemCount: supports.length,
                    itemBuilder: (context, index) {
                      final support = supports[index];
                      String currentDate = formatDate(support.createdAt);
                      bool isFirstInGroup = index == 0 ||
                          formatDate(supports[index - 1].createdAt) != currentDate;
                      final statusInfo = statusMap[support.status] ??
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
                                  builder: (context) =>
                                      SupportDetailBlocProvider(
                                    supportId: support.id,
                                  ),
                                ),
                              );
                            },
                            child: StickyHeader(
                              header: isFirstInGroup
                                  ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8),
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
                                margin: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
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
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: statusInfo['containerColor'],
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(14),
                                          topRight: Radius.circular(14),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.support_agent,
                                            color: statusInfo['textColor'],
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ticket ID',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      statusInfo['textColor'],
                                                ),
                                              ),
                                              Text(
                                                '# ${support.id}',
                                                style: TextStyle(
                                                    color:
                                                        statusInfo['textColor'],
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          PopupMenuButton<String>(
                                            itemBuilder: (_) => [
                                              PopupMenuItem<String>(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                            ],
                                            icon: Container(
                                              decoration: BoxDecoration(
                                                color: statusInfo[
                                                    'containerColor'],
                                              ),
                                              child: Icon(
                                                Icons.more_vert,
                                                color: statusInfo['textColor'],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                                const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.category_outlined,
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text('Module'),
                                                  ],
                                                ),
                                                Text(
                                                  support.moduleName,
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
                                                const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.access_time,
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text('Status'),
                                                  ],
                                                ),
                                                Text(
                                                  support.statusName,
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
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.description_outlined,
                                                color: Colors.orange,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'Description',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            support.description,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else if (state is FailureSupportListState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is InternalServerErrorSupportListState) {
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
