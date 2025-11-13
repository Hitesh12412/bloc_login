import 'dart:io';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_data/agreement_screen/bloc/create_agreement_bloc/create_agreement_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_data/agreement_screen/bloc/create_agreement_bloc/create_agreement_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_data/agreement_screen/bloc/create_agreement_bloc/create_agreement_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';


class CreateAgreementScreen extends StatefulWidget {
  final String dbConnection;
  final int employeeId;

  const CreateAgreementScreen({
    super.key,
    this.dbConnection = "erp_tata_steel_demo",
    required this.employeeId,
  });

  @override
  State<CreateAgreementScreen> createState() => _CreateAgreementScreenState();
}

class _CreateAgreementScreenState extends State<CreateAgreementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _associationTypeController = TextEditingController();
  DateTime? _startDate, _endDate, _dueDate;
  File? _selectedFile;

  void _pickStartDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: now,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;

        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = null;
        }
        if (_dueDate != null && _dueDate!.isBefore(picked)) {
          _dueDate = null;
        }
      });
    }
  }

  void _pickEndDate() async {
    final start = _startDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? start,
      firstDate: start,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
        if (_dueDate != null && _dueDate!.isBefore(picked)) {
          _dueDate = null;
        }
      });
    }
  }

  void _pickDueDate() async {
    final start = _startDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? start,
      firstDate: start,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate() ||
        _startDate == null ||
        _endDate == null ||
        _dueDate == null ||
        _selectedFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("All fields are required.")));
      return;
    }
    // context.read<CreateAgreementBloc>().add(
    //   SubmitAgreementEvent(
    //     dbConnection: widget.dbConnection,
    //     employeeId: widget.employeeId,
    //     associationType: _associationTypeController.text.trim(),
    //     startDate: _startDate!,
    //     endDate: _endDate!,
    //     dueDate: _dueDate!,
    //     document: _selectedFile!,
    //   ),
    // );
  }

  Widget _datePicker(String label, DateTime? value, VoidCallback onTap) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
          margin: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]! ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value != null ? DateFormat('dd/MM/yyyy').format(value) : label),
              const Icon(Icons.calendar_today, color: Colors.blue),
            ],
          ),
        ),
      );

  Widget _filePicker() => InkWell(
    onTap: _pickFile,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]! ),
      ),
      child: Row(
        children: [
          const Icon(Icons.upload_file, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _selectedFile?.path.split('/').last ?? "Upload Agreement File",
              style: TextStyle(color: _selectedFile != null ? Colors.black : Colors.blueGrey),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    _associationTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateAgreementBloc(),
      child: Builder(
        builder: (blocContext) => Scaffold(
          appBar: AppBar(title: const Text("Create Agreement")),
          body: BlocListener<CreateAgreementBloc, CreateAgreementState>(
            listener: (context, state) {
              if (state is CreateAgreementSuccess) {
                Navigator.pop(context, true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Agreement created successfully!')),
                );
              } else if (state is CreateAgreementFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: BlocBuilder<CreateAgreementBloc, CreateAgreementState>(
              builder: (context, state) {
                final isLoading = state is CreateAgreementLoading;

                return AbsorbPointer(
                  absorbing: isLoading,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _associationTypeController,
                            decoration: InputDecoration(
                              labelText: "Association Type",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (val) =>
                            val == null || val.trim().isEmpty ? "Required" : null,
                          ),
                          const SizedBox(height: 16),
                          _datePicker("Start Date", _startDate, _pickStartDate),
                          _datePicker("End Date", _endDate, _pickEndDate),
                          _datePicker("Appraisal Due Date", _dueDate, _pickDueDate),
                          _filePicker(),
                          const SizedBox(height: 28),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : () => _submitForm(blocContext),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("Save", style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
