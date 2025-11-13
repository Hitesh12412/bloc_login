import 'dart:io';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/create_employee_bloc/create_employee_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/create_employee_bloc/create_employee_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/bloc/create_employee_bloc/create_employee_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/repo/create_employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _designationController = TextEditingController();
  final _joiningDateController = TextEditingController();
  String? _gender;

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  void _onSave() {
    if (_nameController.text.isEmpty ||
        _codeController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _birthDateController.text.isEmpty ||
        _designationController.text.isEmpty ||
        _joiningDateController.text.isEmpty ||
        _gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select gender')),
      );
      return;
    }


    context.read<CreateEmployeeBloc>().add(
      SubmitCreateEmployeeEvent(
        name: _nameController.text.trim(),
        designation: _designationController.text.trim(),
        dateOfBirth: _birthDateController.text.trim().replaceAll('/', '-'),
        dateOfJoining: _joiningDateController.text.trim().replaceAll('/', '-'),
        email: _emailController.text.trim(),
        mobileNo: _phoneController.text.trim(),
        employeeCode: _codeController.text.trim(),
        profilePicture: _profileImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateEmployeeBloc(CreateEmployeeRepository()),
      child: BlocListener<CreateEmployeeBloc, CreateEmployeeState>(
        listener: (context, state) {
          if (state is CreateEmployeeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Employee created successfully!'), backgroundColor: Colors.green),
            );
            _nameController.clear();
            _codeController.clear();
            _phoneController.clear();
            _emailController.clear();
            _birthDateController.clear();
            _designationController.clear();
            _joiningDateController.clear();
            setState(() {
              _profileImage = null;
              _gender = null;
            });
          } else if (state is CreateEmployeeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create employee: ${state.error}'), backgroundColor: Colors.red),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF6FAFF),
          appBar: AppBar(
            elevation: 0,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Add Employee",
              style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 5,
                shadowColor: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.person, color: Color(0xFF169FE6)),
                          SizedBox(width: 7),
                          Text("Personal Information",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _buildFormField(_nameController, "Employee Name"),
                      _buildFormField(_codeController, "Employee Code"),
                      _buildFormField(_phoneController, "Phone Number", keyboardType: TextInputType.phone),
                      _buildFormField(_emailController, "Email Address", keyboardType: TextInputType.emailAddress),
                      _buildDateField(context, _birthDateController, "Birth Date"),
                      _buildFormField(_designationController, "Designation"),
                      _buildDateField(context, _joiningDateController, "Joining Date"),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.people, color: Color(0xFF169FE6)),
                          const SizedBox(width: 8),
                          const Text('Gender', style: TextStyle(fontSize: 16)),
                          const Spacer(),
                          Radio<String>(
                            value: 'Male',
                            groupValue: _gender,
                            onChanged: (value) => setState(() => _gender = value),
                          ),
                          const Text('Male'),
                          const SizedBox(width: 10),
                          Radio<String>(
                            value: 'Female',
                            groupValue: _gender,
                            onChanged: (value) => setState(() => _gender = value),
                          ),
                          const Text('Female'),
                        ],
                      ),
                      const SizedBox(height: 22),
                      BlocBuilder<CreateEmployeeBloc, CreateEmployeeState>(
                        builder: (context, state) {
                          if (state is CreateEmployeeLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _onSave,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: const Color(0xFF169FE6),
                              ),
                              child: const Text('Save', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(TextEditingController ctl, String label, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        controller: ctl,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: "Write $label...",
          labelStyle: TextStyle(color: Colors.grey[700]),
          hintStyle: TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: const Color(0xFFF6FAFF),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, TextEditingController ctl, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        controller: ctl,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'dd/MM/yyyy',
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () => _pickDate(context, ctl),
          ),
          filled: true,
          fillColor: const Color(0xFFF6FAFF),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        onTap: () => _pickDate(context, ctl),
      ),
    );
  }
}
