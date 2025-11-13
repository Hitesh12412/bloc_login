import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveManagement extends StatefulWidget {
  const LeaveManagement({super.key});

  @override
  State<LeaveManagement> createState() => _LeaveManagementState();
}

class _LeaveManagementState extends State<LeaveManagement> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),),
        title: const Text(
          "Leave Management",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 185,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.account_balance_wallet,
                                color: Colors.blue,
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blue)),
                                child: const Text(
                                  " 00 ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Upcoming Leave',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 185,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.green)),
                                child: const Text(
                                  " 00 ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Approved',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 185,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_outlined,
                                color: Colors.orange,
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.orange),
                                ),
                                child: const Text(
                                  " 00 ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Pending',
                            style: TextStyle(color: Colors.orange),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 185,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: const Text(
                                  " 00 ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Cancelled',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildToggleTabs(),
          const SizedBox(height: 10),

          Expanded(
            child: selectedIndex == 0
                ? ListView(children: _buildPastCards())
                : _buildNoDataFound(),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTabs() {
    final tabWidth = (MediaQuery.of(context).size.width - 20) / 3;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 42,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            alignment: selectedIndex == 0
                ? Alignment.centerLeft
                : selectedIndex == 1
                ? Alignment.center
                : Alignment.centerRight,
            child: Container(
              width: tabWidth,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              final text = (i == 0)
                  ? 'Past'
                  : (i == 1)
                  ? 'Today'
                  : 'Upcoming';
              final isSelected = selectedIndex == i;
              return GestureDetector(
                onTap: () => setState(() => selectedIndex = i),
                child: Container(
                  width: tabWidth,
                  height: 42,
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }


  List<Widget> _buildPastCards() {
    return [
      Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hitesh',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 15,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.orange.shade300),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.orange,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Pending',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.today,
                            color: Colors.blue,
                          ),
                          Text(
                            'Duration',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Text('1 Day',style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: Colors.green,
                          ),
                          Text(
                            'Leave Balance',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Text('00',style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ];
  }

  Widget _buildNoDataFound() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://cdni.iconscout.com/illustration/premium/thumb/no-data-found-illustration-download-in-svg-png-gif-file-formats--office-computer-digital-work-business-pack-illustrations-7265556.png',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          const Text("Data Not Found!"),
        ],
      ),
    );
  }
}
