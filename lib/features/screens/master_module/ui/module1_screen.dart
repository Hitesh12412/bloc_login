import 'package:flutter/material.dart';

class Module1Screen extends StatelessWidget {
  const Module1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Employee',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'Welcome to Module 1',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
