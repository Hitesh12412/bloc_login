import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditScreen extends StatefulWidget {
  final Employee employee;
  const EditScreen({super.key, required this.employee});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  late TextEditingController _designationController;
  late TextEditingController _joiningController;
  late TextEditingController _pfController;
  late TextEditingController _passwordController;

  String selectedGender = 'Male';
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.name);
    _codeController = TextEditingController(text: widget.employee.employeeCode ?? '');
    _phoneController = TextEditingController(text: widget.employee.mobileNo ?? '');
    _emailController = TextEditingController();
    _dobController = TextEditingController();
    _designationController = TextEditingController();
    _joiningController = TextEditingController();
    _pfController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Widget _buildInput({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    Widget? suffixIcon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.wc, color: Colors.blue),
            SizedBox(width: 5),
            Text('Gender', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: ['Male', 'Female'].map((gender) {
            bool isSelected = selectedGender == gender;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedGender = gender),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: isSelected ? Colors.blue : Colors.black54),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                        color: isSelected ? Colors.blue : Colors.black,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        gender,
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 15),
      ],
    );
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
        backgroundColor: Colors.blue,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.only(left: 7),
              margin: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
              const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            ),
          ),
        automaticallyImplyLeading: true,
        title: const Text("Update Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius:50,
                    backgroundImage: widget.employee.employeeProfile.isNotEmpty
                        ? NetworkImage("https://shiserp.com/demo/${widget.employee.employeeProfile}")
                        : null,
                    child: widget.employee.employeeProfile.isEmpty ? const Icon(Icons.person, size: 50) : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.person, size: 24),
                      ),
                      const SizedBox(width: 10),
                      const Text('Personal Information',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildInput(label: "Employee Name", hint: "abc", controller: _nameController),
                  _buildInput(label: "Employee Code", hint: "58", keyboardType: TextInputType.number, controller: _codeController),
                  _buildInput(label: "Phone Number", hint: "9925735489", keyboardType: TextInputType.phone, controller: _phoneController),
                  _buildInput(label: "Email Address", hint: "abc@gmail.com", keyboardType: TextInputType.emailAddress, controller: _emailController),
                  _buildInput(
                    label: "Birth Date",
                    hint: "01/01/2025",
                    controller: _dobController,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_rounded, color: Colors.blue),
                      onPressed: () => _selectDate(context, _dobController),
                    ),
                  ),
                  _buildInput(label: "Designation", hint: "Developer", controller: _designationController),
                  _buildInput(
                    label: "Joining Date",
                    hint: "17/07/2025",
                    controller: _joiningController,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_rounded, color: Colors.blue),
                      onPressed: () => _selectDate(context, _joiningController),
                    ),
                  ),
                  _buildGenderSelector(),
                  _buildInput(
                      label: "PF Number",
                      hint: "1234",
                      keyboardType: TextInputType.number,
                      controller: _pfController),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.security, color: Colors.blue)),
                      const SizedBox(width: 10),
                      const Text(
                        'Security & Media',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildInput(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Save or update API logic here using controller values
                // Example: _nameController.text, selectedGender, etc.
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.update, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
