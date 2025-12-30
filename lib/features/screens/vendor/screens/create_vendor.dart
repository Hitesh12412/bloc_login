import 'package:bloc_login/features/screens/master/model/branch_model/branch_model_class.dart';
import 'package:bloc_login/features/screens/master/screen/branch_screen/branch_screen.dart';
import 'package:bloc_login/features/screens/vendor/bloc/create_vendor_bloc/create_vendor_bloc.dart';
import 'package:bloc_login/features/screens/vendor/bloc/create_vendor_bloc/create_vendor_event.dart';
import 'package:bloc_login/features/screens/vendor/bloc/create_vendor_bloc/create_vendor_state.dart';
import 'package:bloc_login/features/screens/vendor/bloc/vendor_level/vendor_level_bloc.dart';
import 'package:bloc_login/features/screens/vendor/bloc/vendor_level/vendor_level_event.dart';
import 'package:bloc_login/features/screens/vendor/bloc/vendor_level/vendor_level_state.dart';
import 'package:bloc_login/features/screens/vendor/model/vendor_level_model.dart';
import 'package:bloc_login/features/screens/vendor/screens/for_vendor_product_list.dart';
import 'package:bloc_login/features/screens/product_module/model/products_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateVendorView extends StatelessWidget {
  const CreateVendorView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VendorCreateBloc()),
        BlocProvider(
          create: (_) => VendorLevelBloc()
            ..add(const FetchVendorLevels(
              dbConnection: 'erp_tata_steel_demo',
            )),
        ),
      ],
      child: const CreateVendor(),
    );
  }
}

class CreateVendor extends StatefulWidget {
  const CreateVendor({super.key});

  @override
  State<CreateVendor> createState() => _CreateVendorState();
}

class _CreateVendorState extends State<CreateVendor> {
  final _formKey = GlobalKey<FormState>();

  final _vendorNameCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _whatsappCtrl = TextEditingController();
  final _vendorEmailCtrl = TextEditingController();
  final _gstCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _branchCtrl = TextEditingController();

  bool isWhatsappSameAsMobile = false;

  VendorLevelModel? selectedLevel;
  int? selectedBranchId;
  List<ProductListModel> selectedProducts = [];

  @override
  void initState() {
    super.initState();
    _mobileCtrl.addListener(() {
      if (isWhatsappSameAsMobile) {
        _whatsappCtrl.text = _mobileCtrl.text;
      }
    });
  }

  @override
  void dispose() {
    _vendorNameCtrl.dispose();
    _companyCtrl.dispose();
    _mobileCtrl.dispose();
    _whatsappCtrl.dispose();
    _vendorEmailCtrl.dispose();
    _gstCtrl.dispose();
    _addressCtrl.dispose();
    _branchCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedLevel == null) {
      _showError('Please select Vendor Level');
      return;
    }

    if (selectedBranchId == null) {
      _showError('Please select Branch');
      return;
    }

    if (selectedProducts.isEmpty) {
      _showError('Please select at least one Product');
      return;
    }

    if (_whatsappCtrl.text.trim().isEmpty) {
      _showError('Please enter WhatsApp number');
      return;
    }

    context.read<VendorCreateBloc>().add(
          VendorCreateRequested(
            userId: '1',
            vendorName: _vendorNameCtrl.text.trim(),
            vendorCompanyName: _companyCtrl.text.trim(),
            vendorEmail: _vendorEmailCtrl.text.trim(),
            mobileNumber: _mobileCtrl.text.trim(),
            whatsappNumber: _whatsappCtrl.text.trim(),
            gstNumber: _gstCtrl.text.trim(),
            address: _addressCtrl.text.trim(),
            vendorLevelId: selectedLevel!.id.toString(),
            branchId: selectedBranchId!.toString(),
            productId: selectedProducts.map((e) => e.id).join(','),
          ),
        );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red.shade400,
      ),
    );
  }

  Future<void> _selectProducts() async {
    final result = await Navigator.push<List<ProductListModel>>(
      context,
      MaterialPageRoute(
        builder: (_) => const ProductSelectSingleScreenView(),
      ),
    );

    if (result != null) {
      setState(() => selectedProducts = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 5),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(8)),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon:
                const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        titleSpacing: 0,
        title: const Text(
          'Create Vendor',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<VendorCreateBloc, VendorCreateState>(
        listener: (context, state) {
          if (state is VendorCreateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
          if (state is VendorCreateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade400,
              ),
            );
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is VendorCreateLoading,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _field(
                      controller: _vendorNameCtrl,
                      label: 'Vendor Name',
                      hintText: 'Enter vendor name...',
                    ),
                    _field(
                      controller: _companyCtrl,
                      label: 'Company Name',
                      hintText: 'Enter company name...',
                    ),
                    _field(
                      controller: _mobileCtrl,
                      label: 'Mobile Number',
                      hintText: 'Enter mobile number...',
                      keyboard: TextInputType.phone,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.messenger_outline,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'WhatsApp number is same as phone number',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Auto-fill whatsApp Number from phone',
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 1.4,
                            child: Checkbox(
                              value: isWhatsappSameAsMobile,
                              shape: const CircleBorder(),
                              side: const BorderSide(color: Colors.grey),
                              visualDensity: const VisualDensity(
                                horizontal: -3,
                                vertical: -3,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  isWhatsappSameAsMobile = val ?? false;
                                  if (isWhatsappSameAsMobile) {
                                    _whatsappCtrl.text = _mobileCtrl.text;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    _field(
                      controller: _whatsappCtrl,
                      label: 'WhatsApp Number',
                      hintText: 'Enter WhatsApp number...',
                      keyboard: TextInputType.phone,
                    ),
                    _field(
                      controller: _vendorEmailCtrl,
                      label: 'Email',
                      hintText: 'Enter email...',
                      keyboard: TextInputType.emailAddress,
                    ),
                    _field(
                      controller: _gstCtrl,
                      label: 'GST Number',
                      hintText: 'Enter GST number...',
                    ),
                    BlocBuilder<VendorLevelBloc, VendorLevelState>(
                      builder: (context, state) {
                        if (state is! VendorLevelLoaded) {
                          return _dropdown(
                              'Vendor Level', 'Select Vendor Level');
                        }
                        return _dropdown(
                          'Vendor Level',
                          selectedLevel?.name ?? 'Select Vendor Level',
                          items: state.levels,
                          onChanged: (val) {
                            setState(() => selectedLevel = val);
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () async {
                        final BranchData? branch = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BranchSelectView(),
                          ),
                        );
                        if (branch != null) {
                          setState(() {
                            _branchCtrl.text = branch.name;
                            selectedBranchId = branch.id;
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: _field(
                          controller: _branchCtrl,
                          label: 'Branch',
                          hintText: 'Select branch',
                        ),
                      ),
                    ),
                    _productSelector(),
                    _field(
                      controller: _addressCtrl,
                      label: 'Address',
                      hintText: 'Enter address...',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _submit();
                      },
                      child: state is VendorCreateLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Add Vendor',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _productSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'Select Products',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          if (selectedProducts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedProducts.map((e) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      e.name,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: _selectProducts,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue),
                ),
                child: const Text(
                  '+  Add Product',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: keyboard,
            maxLines: maxLines,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            decoration: InputDecoration(
              hintText: hintText,
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

  Widget _dropdown(
    String label,
    String hint, {
    List<VendorLevelModel> items = const [],
    ValueChanged<VendorLevelModel?>? onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<VendorLevelModel>(
          isExpanded: true,
          value: null,
          hint: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.blue, fontSize: 12),
              ),
              Text(
                hint,
                style: TextStyle(
                    color: hint.startsWith('Select')
                        ? Colors.grey.shade400
                        : Colors.black,
                    fontSize: 15),
              ),
            ],
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
