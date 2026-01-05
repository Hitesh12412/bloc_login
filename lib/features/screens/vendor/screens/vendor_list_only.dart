import 'package:bloc_login/features/screens/vendor/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/vendors_list_bloc/vendors_list_bloc.dart';
import '../bloc/vendors_list_bloc/vendors_list_event.dart';
import '../model/vendors_list_model.dart';

class VendorSelectionPage extends StatelessWidget {
  const VendorSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      VendorsListBloc()..add( FetchVendorsListEvent()),
      child: const VendorSelectionScreen(),
    );
  }
}

class VendorSelectionScreen extends StatefulWidget {
  const VendorSelectionScreen({super.key});

  @override
  State<VendorSelectionScreen> createState() =>
      _VendorSelectionScreenState();
}

class _VendorSelectionScreenState
    extends State<VendorSelectionScreen> {
  VendorData? selectedVendor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        title: const Text(
          'Select Vendor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: Container(
          padding: const EdgeInsets.only(left: 5),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        titleSpacing: 0,
      ),
      body: BlocBuilder<VendorsListBloc, VendorsListStates>(
        builder: (context, state) {
          if (state is LoadingVendorsListState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FailureVendorsListState) {
            return Center(child: Text(state.error));
          }

          if (state is LoadedVendorsListState) {
            final vendors = state.model.data;

            if (vendors.isEmpty) {
              return const Center(child: Text('No vendors found'));
            }

            return ListView.builder(
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                final vendor = vendors[index];
                final isSelected = selectedVendor?.id == vendor.id;
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedVendor = vendor);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              shape: const CircleBorder(),
                              fillColor: WidgetStateProperty.resolveWith(
                                    (states) =>
                                states.contains(WidgetState.selected)
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                              checkColor: WidgetStateProperty.all(Colors.white),
                            ),
                          ),
                          child: Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: isSelected,
                              onChanged: (_) {
                                setState(() => selectedVendor = vendor);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vendor.vendorName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                              const Spacer(),
                              if (isSelected)
                                Container(
                                  padding: const EdgeInsets.only(top: 2, bottom: 2, left: 7, right: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blue.shade700,
                                  ),
                                  child: const Text(
                                    'Selected',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
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
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: GestureDetector(
          onTap: selectedVendor == null
              ? null
              : () {
            Navigator.pop(context, {
              'vendorId': selectedVendor!.id,
              'vendorName': selectedVendor!.vendorName,
              'pendingAmount':
              double.tryParse(
                selectedVendor!.totalOutstandingPayment
                    .toString(),
              ) ??
                  0.0,
            });
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade700
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Save Selection',
                  style: TextStyle(fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
