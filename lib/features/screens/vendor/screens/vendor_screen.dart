import 'dart:ui';

import 'package:bloc_login/features/screens/vendor/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:bloc_login/features/screens/vendor/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:bloc_login/features/screens/vendor/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VendorsListBloc>(
      create: (context) => VendorsListBloc()
        ..add(
          FetchVendorsListEvent(),
        ),
      child: const VendorScreenView(),
    );
  }
}

class VendorScreenView extends StatefulWidget {
  const VendorScreenView({super.key});

  @override
  State<VendorScreenView> createState() => _VendorScreenViewState();
}

class _VendorScreenViewState extends State<VendorScreenView> {
  Timer? _typingTimer;
  String _animatedLabel = '';
  int _currentCharIndex = 0;
  int _currentTextIndex = 0;
  final List<String> _labelTexts = [
    'Search Vendor Name...',
    'Search by Name...',
    'Find Vendor...',
    'Type Vendor Name...',
  ];

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  void _startTypingAnimation() {
    _typingTimer?.cancel();
    _currentCharIndex = 0;
    _animatedLabel = '';

    _typingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_currentCharIndex < _labelTexts[_currentTextIndex].length) {
          _animatedLabel = _labelTexts[_currentTextIndex]
              .substring(0, _currentCharIndex + 1);
          _currentCharIndex++;
        } else {
          timer.cancel();
          Future.delayed(const Duration(seconds: 2), () {
            _currentTextIndex = (_currentTextIndex + 1) % _labelTexts.length;
            _startTypingAnimation();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: const Icon(Icons.dashboard_rounded,
              size: 36, color: Colors.white),
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
              child: const Icon(Icons.notifications,
                  size: 28, color: Colors.black)),
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
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vendor',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Manage your vendors',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                labelText: _animatedLabel,
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(CupertinoIcons.person_alt_circle,
                      color: Colors.blue.shade700, size: 28),
                ),
                const SizedBox(width: 10),
                const Column(
                  children: [
                    Text(
                      'Total Vendors',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '11',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<VendorsListBloc, VendorsListStates>(
              builder: (context, state) {
                if (state is LoadingVendorsListState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedVendorsListState) {
                  final vendors = state.model.data;
                  if (vendors.isEmpty) {
                    return _noDataWidget();
                  }
                  return ListView.builder(
                    itemCount: vendors.length,
                    itemBuilder: (context, index) {
                      final Vendors = vendors[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: false,
                              enableDrag: false,
                              context: context,
                              barrierColor: Colors.black.withOpacity(0.4),
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 20,
                                        bottom: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 17,
                                                  right: 17,
                                                  top: 7,
                                                  bottom: 7),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                Vendors.vendorName.isNotEmpty
                                                    ? Vendors.vendorName[0]
                                                        .toUpperCase()
                                                    : 'C',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              children: [
                                                const Text(
                                                  "Vendor Details",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  Vendors.vendorName,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        Colors.blue.shade200),
                                              ),
                                              child: Icon(Icons.edit,
                                                  color: Colors.blue.shade800,
                                                  size: 25),
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 25,
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        const Text(
                                          'Basic Information',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.email,
                                                  color: Colors.blue,
                                                  size: 25,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Email Address',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    Vendors.vendorEmail,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .grey.shade700),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.phone,
                                                  color: Colors.blue,
                                                  size: 25,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Phone Number',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      const CircularProgressIndicator(
                                                        color: Colors.blue,
                                                      );
                                                      _launchDialer(
                                                          Vendors.mobileNumber);
                                                    },
                                                    child: Text(
                                                      Vendors.mobileNumber,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              Colors.blue,
                                                          decorationThickness:
                                                              1.5,
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .solid),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.blue,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Business Information',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.inventory_outlined,
                                                  color: Colors.blue,
                                                  size: 25,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Product Name',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    Vendors.vendorName,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .grey.shade700),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.blue,
                                                  size: 25,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Address',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      Vendors.address,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade700),
                                                    )
                                                  ],
                                                ),
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
                                              Vendors.vendorName.isNotEmpty
                                                  ? Vendors.vendorName[0]
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
                                                    Vendors.vendorName,
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
                                              Vendors.vendorEmail.isNotEmpty
                                                  ? Vendors.vendorEmail
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
                                                    '${Vendors.vendorName} Deleted Successfully !',
                                                  ),
                                                  backgroundColor: Colors.red,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                   
                                                            8),
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
                                                color: Colors.orange.shade100),
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
                                          GestureDetector(
                                            onTap: () {
                                              const CircularProgressIndicator(
                                                color: Colors.blue,
                                              );
                                              _launchDialer(
                                                  Vendors.mobileNumber);
                                            },
                                            child: Text(
                                              Vendors.mobileNumber.isNotEmpty
                                                  ? Vendors.mobileNumber
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
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      if (Vendors.vendorLevelName.isNotEmpty)
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 2,
                                            bottom: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.blue.shade300),
                                          ),
                                          child: Text(
                                            Vendors.vendorLevelName,
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
                  );
                } else if (state is FailureVendorsListState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is InternalServerErrorVendorsListState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _launchDialer(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
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
