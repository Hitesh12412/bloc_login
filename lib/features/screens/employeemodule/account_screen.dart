import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FBFF),
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
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),),
        automaticallyImplyLeading: false,
        title: const Text(
          "Account Details",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Personal Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildField(label: "Your Name", initialValue: "Hitesh"),
              _buildField(
                  label: "Phone Number", initialValue: "+91-9571763167"),
              _buildField(
                  label: "Email Address", initialValue: "hitesh@gmail.com"),
              _buildField(label: "Working Shift", initialValue: "Regular"),
              _buildField(label: "Paid Leave", initialValue: "10"),
              _buildField(label: "Available Paid Leave", initialValue: "10"),
              _buildField(label: "Country", initialValue: "India"),
              _buildField(label: "State", initialValue: "Gujarat"),
              _buildField(label: "City", initialValue: "Ahmedabad"),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    /////////////////////////////
                    print("Updated");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Update",
                        style: TextStyle(fontSize: 16,color: Colors.white),
                      ),
                      Icon(Icons.chevron_right_outlined,color: Colors.white,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String label, required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
