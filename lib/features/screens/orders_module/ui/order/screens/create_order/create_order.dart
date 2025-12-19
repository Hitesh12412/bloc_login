import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/create_order/create_order_bloc.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/create_order/create_order_event.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/create_order/create_order_state.dart';

import 'package:bloc_login/features/screens/orders_module/ui/order/screens/add_product/add_product_screen.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/model/client_list/client_list_model_class.dart';

import 'package:bloc_login/features/screens/master/model/country_model/country_model.dart';
import 'package:bloc_login/features/screens/master/model/state_model/state_model.dart';
import 'package:bloc_login/features/screens/master/model/city_model/city_screen.dart';

import 'package:bloc_login/features/screens/master/screen/country_screen/country_screen.dart';
import 'package:bloc_login/features/screens/master/screen/state_screen/state_screen.dart';
import 'package:bloc_login/features/screens/master/screen/city_screen/city_screen.dart';

import 'package:bloc_login/features/screens/master/model/branch_model/branch_model_class.dart';
import 'package:bloc_login/features/screens/master/screen/branch_screen/branch_screen.dart';

class CreateOrderView extends StatelessWidget {
  final ClientData selectedClient;

  const CreateOrderView({super.key, required this.selectedClient});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCreateBloc(),
      child: CreateOrderScreen(selectedClient: selectedClient),
    );
  }
}

class CreateOrderScreen extends StatefulWidget {
  final ClientData selectedClient;

  const CreateOrderScreen({super.key, required this.selectedClient});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final clientNameCtrl = TextEditingController();
  final clientPhoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  final billingAddressCtrl = TextEditingController();
  final billingCountryCtrl = TextEditingController();
  final billingStateCtrl = TextEditingController();
  final billingCityCtrl = TextEditingController();
  final billingPincodeCtrl = TextEditingController();

  final shippingAddressCtrl = TextEditingController();
  final shippingCountryCtrl = TextEditingController();
  final shippingStateCtrl = TextEditingController();
  final shippingCityCtrl = TextEditingController();
  final shippingPincodeCtrl = TextEditingController();

  final branchCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  int? selectedBranchId;
  int? billingCountryId;
  int? billingStateId;
  int? billingCityId;

  int? shippingCountryId;
  int? shippingStateId;
  int? shippingCityId;

  bool shippingSame = true;

  List<Map<String, dynamic>> selectedProducts = [];


  String _v(Map<String, dynamic> p, String key, [String def = '0']) {
    final val = p[key];
    if (val == null) return def;
    return val.toString();
  }


  @override
  void initState() {
    super.initState();

    final c = widget.selectedClient;

    clientNameCtrl.text = c.customerName;
    clientPhoneCtrl.text = c.mobileNo;
    emailCtrl.text = c.email;
    addressCtrl.text = c.address ?? '';

    billingAddressCtrl.text = c.address ?? '';
    billingCountryCtrl.text = c.billingCountryName ?? '';
    billingStateCtrl.text = c.billingStateName ?? '';
    billingCityCtrl.text = c.billingCityName ?? '';
    billingPincodeCtrl.text = c.billingPincode ?? '';

    billingCountryId = int.tryParse(c.billingCountryId?.toString() ?? '');
    billingStateId = int.tryParse(c.billingStateId?.toString() ?? '');
    billingCityId = int.tryParse(c.billingCityId?.toString() ?? '');

    _syncShippingWithBilling();
  }

  void _syncShippingWithBilling() {
    shippingAddressCtrl.text = billingAddressCtrl.text;
    shippingCountryCtrl.text = billingCountryCtrl.text;
    shippingStateCtrl.text = billingStateCtrl.text;
    shippingCityCtrl.text = billingCityCtrl.text;
    shippingPincodeCtrl.text = billingPincodeCtrl.text;

    shippingCountryId = billingCountryId;
    shippingStateId = billingStateId;
    shippingCityId = billingCityId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCreateBloc, OrderCreateState>(
      listener: (context, state) {
        if (!mounted) return;

        if (state is OrderCreateSuccess) {
          _showSuccessSnackBar(state.message);
        }

        if (state is OrderCreateFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          });
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.blue.shade50,
          appBar: AppBar(
            leading: Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios,
                      size: 20, color: Colors.white)),
            ),
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),),),
            titleSpacing: 0,
            title: const Text(
              'Create Order',
              style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),

          bottomNavigationBar: _bottomButton(state),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _field('Customer Name', clientNameCtrl),
                _field('Mobile No', clientPhoneCtrl),
                _field('Email', emailCtrl),
                _field('Address', addressCtrl),

                GestureDetector(
                  onTap: () async {
                    final BranchData? branch = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BranchSelectView()),
                    );
                    if (branch != null) {
                      setState(() {
                        branchCtrl.text = branch.name;
                        selectedBranchId = branch.id;
                      });
                    }
                  },
                  child:
                  AbsorbPointer(child: _field('Branch', branchCtrl)),
                ),

                const SizedBox(height: 16),
                _section('Billing Address'),

                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12,top: 20,bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _field('Billing Address', billingAddressCtrl),

                      _selectField(
                        label: 'Country',
                        ctrl: billingCountryCtrl,
                        onTap: () async {
                          final CountryData? c = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CountrySelectView()),
                          );
                          if (c != null) {
                            setState(() {
                              billingCountryCtrl.text = c.name;
                              billingCountryId = c.id;
                              billingStateCtrl.clear();
                              billingCityCtrl.clear();
                              billingStateId = null;
                              billingCityId = null;
                              if (shippingSame) _syncShippingWithBilling();
                            });
                          }
                        },
                      ),

                      _selectField(
                        label: 'State',
                        ctrl: billingStateCtrl,
                        onTap: billingCountryId == null
                            ? null
                            : () async {
                          final StateData? s = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => StateSelectView(
                                  countryId: billingCountryId!),
                            ),
                          );
                          if (s != null) {
                            setState(() {
                              billingStateCtrl.text = s.name;
                              billingStateId = s.id;
                              billingCityCtrl.clear();
                              billingCityId = null;
                              if (shippingSame) _syncShippingWithBilling();
                            });
                          }
                        },
                      ),

                      _selectField(
                        label: 'City',
                        ctrl: billingCityCtrl,
                        onTap: billingStateId == null
                            ? null
                            : () async {
                          final CityData? c = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CitySelectView(stateId: billingStateId!),
                            ),
                          );
                          if (c != null) {
                            setState(() {
                              billingCityCtrl.text = c.name;
                              billingCityId = c.id;
                              if (shippingSame) _syncShippingWithBilling();
                            });
                          }
                        },
                      ),

                      _field('Billing Pincode', billingPincodeCtrl),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                      value: shippingSame,
                      activeColor: Colors.blue,
                      onChanged: (v) {
                        setState(() {
                          shippingSame = v ?? true;
                          if (shippingSame) {
                            _syncShippingWithBilling();
                          }
                        });
                      },
                    ),
                    const Text('Shipping address same as Billing'),
                  ],
                ),

                const SizedBox(height: 16),
                _section('Shipping Address'),
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12,top: 20,bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _field('Shipping Address', shippingAddressCtrl),
                      _field('Shipping Country', shippingCountryCtrl),
                      _field('Shipping State', shippingStateCtrl),
                      _field('Shipping City', shippingCityCtrl),
                      _field('Shipping Pincode', shippingPincodeCtrl),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                _field('Description', descriptionCtrl),

                if (selectedProducts.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _section('Products'),
                  ...selectedProducts.map(_productTile),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddProductScreen(),
                          ),
                        );

                        if (result != null && result is Map<String, dynamic>) {
                          setState(() {
                            selectedProducts.add(result);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          const Text('Add Product',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.add,color: Colors.white,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _productTile(Map<String, dynamic> p) {
    final totalMrp = double.tryParse(_v(p, 'total_mrp')) ?? 0;
    final discount = double.tryParse(_v(p, 'total_discount')) ?? 0;
    final taxable = double.tryParse(_v(p, 'new_total_mrp')) ?? 0;
    final cgst = double.tryParse(_v(p, 'cgst_value')) ?? 0;
    final sgst = double.tryParse(_v(p, 'sgst_value')) ?? 0;
    final total = double.tryParse(_v(p, 'order_total')) ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFFEFF8F2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.shopping_bag,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Product ID: ${_v(p, 'product_id')}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Qty: ${_v(p, 'qty')}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          _summaryRow(Icons.sell_outlined, 'Total MRP', totalMrp, Colors.green),
          _summaryRow(
              Icons.local_offer_outlined, 'Discount', -discount, Colors.red),
          _summaryRow(
              Icons.receipt_long_outlined, 'Taxable Value', taxable, Colors.green),
          _summaryRow(
              Icons.account_balance_outlined, 'CGST', cgst, Colors.orange),
          _summaryRow(
              Icons.account_balance_outlined, 'SGST', sgst, Colors.orange),

          Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF8F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.payments, color: Colors.green),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Product Total',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '₹ ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
      IconData icon, String label, double value, Color color) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey.shade600),
              const SizedBox(width: 12),
              Expanded(child: Text(label)),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withOpacity(0.4)),
                ),
                child: Text(
                  '${value >= 0 ? '+' : '-'} ₹ ${value.abs().toStringAsFixed(2)}',
                  style:
                  TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade200, height: 1),
      ],
    );
  }


  Widget _bottomButton(OrderCreateState state) {
    final loading = state is OrderCreateLoading;
    return Container(
      padding: const EdgeInsets.all(12),
      child: ElevatedButton(
        onPressed: loading ? null : _submit,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 14)),
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Create Order',
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _submit() {
    context.read<OrderCreateBloc>().add(
      OrderCreateRequested(
        userId: '1',
        customerId: widget.selectedClient.id.toString(),
        branchId: selectedBranchId?.toString() ?? '',
        customerName: clientNameCtrl.text,
        email: emailCtrl.text,
        mobileNo: clientPhoneCtrl.text,
        address: addressCtrl.text,
        billingAddress: billingAddressCtrl.text,
        billingCountryId: billingCountryId?.toString() ?? '',
        billingStateId: billingStateId?.toString() ?? '',
        billingCityId: billingCityId?.toString() ?? '',
        billingPincode: billingPincodeCtrl.text,
        shippingAddress: shippingAddressCtrl.text,
        shippingCountryId: shippingCountryId?.toString() ?? '',
        shippingStateId: shippingStateId?.toString() ?? '',
        shippingCityId: shippingCityId?.toString() ?? '',
        shippingPincode: shippingPincodeCtrl.text,
        description: descriptionCtrl.text,
        orderProductData: jsonEncode(selectedProducts),
        leadId: '',
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }


  Widget _section(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$title :-',
        style:
        const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _field(String title, TextEditingController ctrl, {String? hint}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectField({
    required String label,
    required TextEditingController ctrl,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(child: _field(label, ctrl)),
    );
  }
}
