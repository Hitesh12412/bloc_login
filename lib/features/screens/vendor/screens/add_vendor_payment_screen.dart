import 'package:bloc_login/features/screens/vendor/screens/vendor_list_only.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_vendor_payment_bloc/add_vendor_payment_bloc.dart';
import '../bloc/add_vendor_payment_bloc/add_vendor_payment_event.dart';
import '../bloc/add_vendor_payment_bloc/add_vendor_payment_state.dart';

class AddVendorPaymentPage extends StatelessWidget {
  const AddVendorPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddPaymentBloc(),
      child: const AddVendorPaymentScreen(),
    );
  }
}

class AddVendorPaymentScreen extends StatefulWidget {
  const AddVendorPaymentScreen({super.key});

  @override
  State<AddVendorPaymentScreen> createState() =>
      _AddVendorPaymentScreenState();
}

class _AddVendorPaymentScreenState
    extends State<AddVendorPaymentScreen> {
  int? vendorId;
  String? vendorName;
  double pendingAmount = 0.0;

  DateTime transactionDate = DateTime.now();
  final amountCtrl = TextEditingController();
  final remarkCtrl = TextEditingController();

  String? selectedPaymentMethod;

  final List<String> paymentMethods = const [
    'Cash',
    'Cheque',
    'Credit/Debit Card',
    'Internet Banking',
    'Google Pay',
    'PhonePe',
    'Paytm',
    'RazorPay',
    'Other',
  ];

  Future<void> _selectVendor() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VendorSelectionPage(),
      ),
    );

    if (result != null) {
      setState(() {
        vendorId = result['vendorId'];
        vendorName = result['vendorName'];
        pendingAmount = result['pendingAmount'];
      });
    }
  }

  void _submit() {
    final enteredAmount = double.tryParse(amountCtrl.text) ?? 0;

    if (enteredAmount <= 0) {
      _toast('Enter valid amount');
      return;
    }

    if (enteredAmount > pendingAmount) {
      _toast('You cannot add amount more than pending');
      return;
    }

    if (selectedPaymentMethod == null) {
      _toast('Select payment method');
      return;
    }

    context.read<AddPaymentBloc>().add(
      AddPaymentRequested(
        userId: 1,
        vendorId: vendorId!,
        date: transactionDate.toIso8601String(),
        collectedPayment: enteredAmount.toString(),
        paymentMethod: selectedPaymentMethod!,
        remarks: remarkCtrl.text,
      ),
    );
  }

  void _toast(String msg) {
    Color bgColor;
    if (msg.toLowerCase().contains('success') ||
        msg.toLowerCase().contains('added') ||
        msg.toLowerCase().contains('saved')) {
      bgColor = Colors.green.shade600;
    } else if (msg.toLowerCase().contains('select') ||
        msg.toLowerCase().contains('enter')) {
      bgColor = Colors.orange.shade700;
    } else {
      bgColor = Colors.red.shade600;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final vendorSelected = vendorId != null;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        title: const Text(
          'Add Vendor Payment',
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


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _selectVendorTile(),

            if (vendorSelected) ...[
              _dateTile(),
              _outstandingTile(),
              _addAmountField(),
              _paymentMethodTile(),
              _remarkField(),
              const SizedBox(height: 20),
              _submitButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _selectVendorTile() {
    final bool hasVendor = vendorName != null;

    return GestureDetector(
      onTap: _selectVendor,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Vendor',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    hasVendor
                        ? vendorName!
                        : 'Tap to select Vendor...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      hasVendor ? FontWeight.w600 : FontWeight.w400,
                      color: hasVendor
                          ? Colors.black
                          : Colors.grey.shade500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateTile() {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: transactionDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          setState(() => transactionDate = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transaction Date',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${transactionDate.day}/${transactionDate.month}/${transactionDate.year}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.calendar_today,
                size: 18,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _outstandingTile() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Outstanding Amount',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '₹ ${pendingAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _addAmountField() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Amount',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                TextField(
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    isDense: true,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodTile() {
    return GestureDetector(
      onTap: () async {
        final selected = await showMenu<String>(
          context: context,
          position: const RelativeRect.fromLTRB(20, 300, 20, 0),
          items: paymentMethods
              .map(
                (method) => PopupMenuItem<String>(
              value: method,
              child: Text(method),
            ),
          )
              .toList(),
        );

        if (selected != null) {
          setState(() => selectedPaymentMethod = selected);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedPaymentMethod ??
                        'Tap to select payment method...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: selectedPaymentMethod == null
                          ? Colors.grey.shade500
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _remarkField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Remarks',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: remarkCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write remarks...',
                    isDense: true,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return BlocConsumer<AddPaymentBloc, AddPaymentState>(
      listener: (context, state) {
        if (state is AddPaymentSuccess) {
          _toast(state.message);
          Navigator.pop(context);
        }
        if (state is AddPaymentFailure) {
          _toast(state.error);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap:
            state is AddPaymentLoading ? null : _submit,
            child: state is AddPaymentLoading
                ? const CircularProgressIndicator(color: Colors.white)
                :  Container(
              padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Submit',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                ),),
          ),
        );
      },
    );
  }
}
