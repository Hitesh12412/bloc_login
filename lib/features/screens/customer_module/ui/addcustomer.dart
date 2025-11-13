import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/features/screens/customer_module/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:bloc_login/features/screens/customer_module/bloc/create_customer_bloc/create_customer_event.dart';
import 'package:bloc_login/features/screens/customer_module/bloc/create_customer_bloc/create_customer_state.dart';

class Addcustomer extends StatelessWidget {
  const Addcustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCreateBloc(),
      child: const AddCustomerScreen(),
    );
  }
}

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isWhatsAppSameAsPhone = true;

  void _showSuccessMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showFailureMessage(String error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool _validateInputs() {
    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty) {
      _showFailureMessage('Please fill all required fields');
      return false;
    }
    return true;
  }

  void _createCustomer() {
    if (_validateInputs()) {
      final whatsappNumber = _isWhatsAppSameAsPhone
          ? _phoneController.text.trim()
          : _whatsappController.text.trim();

      context.read<CustomerCreateBloc>().add(
            CustomerCreateRequested(
              dbConnection: 'erp_tata_steel_demo',
              customerName: _nameController.text.trim(),
              email: _emailController.text.trim(),
              mobileNo: _phoneController.text.trim(),
              whatsappNo: whatsappNumber,
              gstNo: _gstController.text.trim().isEmpty
                  ? null
                  : _gstController.text.trim(),
              address: _addressController.text.trim(),
              userId: '1',
              customerLevelId: '1',
              productId: '11',
            ),
          );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _gstController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
        title: const Text(
          'New Customer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                //
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2196F3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(Icons.file_download, size: 18),
              label: const Text('Import'),
            ),
          ),
        ],
      ),
      body: BlocListener<CustomerCreateBloc, CustomerCreateState>(
        listener: (context, state) {
          if (state is CustomerCreateSuccess) {
            _showSuccessMessage(state.message);
            Navigator.pop(context, true);
          } else if (state is CustomerCreateFailure) {
            _showFailureMessage(state.error);
          }
        },
        child: BlocBuilder<CustomerCreateBloc, CustomerCreateState>(
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      controller: _nameController,
                      label: 'Customer Name',
                      hint: 'Enter Customer name...',
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _companyController,
                      label: 'Customer Company Name',
                      hint: 'Enter Customer Company name...',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Customer Phone Name',
                      hint: 'Enter Customer Phone name...',
                      keyboardType: TextInputType.phone,
                      isRequired: true,
                      onChanged: (value) {
                        if (_isWhatsAppSameAsPhone) {
                          _whatsappController.text = value;
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title:
                          const Text('WhatsApp number is same as phone number'),
                      value: _isWhatsAppSameAsPhone,
                      onChanged: (bool? value) {
                        setState(() {
                          _isWhatsAppSameAsPhone = value ?? true;
                          if (_isWhatsAppSameAsPhone) {
                            _whatsappController.text = _phoneController.text;
                          } else {
                            _whatsappController.clear();
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 16),
                    if (!_isWhatsAppSameAsPhone)
                      Column(
                        children: [
                          _buildTextField(
                            controller: _whatsappController,
                            label: 'Customer WhatsApp Name',
                            hint: 'Enter Customer WhatsApp name...',
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Customer Email Address',
                      hint: 'Enter Customer Email Address...',
                      keyboardType: TextInputType.emailAddress,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _gstController,
                      label: 'GST Number',
                      hint: 'Enter GST Number...',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _addressController,
                      label: 'Customer Address',
                      hint: 'Enter Customer Address...',
                      maxLines: 3,
                      isRequired: true,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            state is CustomerCreateLoading ? null : _createCustomer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: state is CustomerCreateLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle_outline),
                                  SizedBox(width: 8),
                                  Text(
                                    'Add Customer',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool isRequired = false,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: isRequired
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
