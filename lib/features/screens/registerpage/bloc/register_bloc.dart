import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../loginpage/ui/login_screen.dart'; // Make sure the path is correct

class RegisterBloc {
  final _nameController = StreamController<String>.broadcast();
  final _usernameController = StreamController<String>.broadcast();
  final _phoneController = StreamController<String>.broadcast();
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  String _name = "";
  String _username = "";
  String _phone = "";
  String _email = "";
  String _password = "";

  Stream<String> get name => _nameController.stream.transform(_validateName);
  Stream<String> get username => _usernameController.stream.transform(_validateUsername);
  Stream<String> get phone => _phoneController.stream.transform(_validatePhone);
  Stream<String> get email => _emailController.stream.transform(_validateEmail);
  Stream<String> get password => _passwordController.stream.transform(_validatePassword);

  Stream<bool> get submitValid =>
      CombineLatestStream.combine5(name, username, phone, email, password, (a, b, c, d, e) => true);
  void changeName(String val) {
    _name = val;
    _nameController.sink.add(val);
  }

  void changeUsername(String val) {
    _username = val;
    _usernameController.sink.add(val);
  }

  void changePhone(String val) {
    _phone = val;
    _phoneController.sink.add(val);
  }

  void changeEmail(String val) {
    _email = val;
    _emailController.sink.add(val);
  }

  void changePassword(String val) {
    _password = val;
    _passwordController.sink.add(val);
  }

  // Validators
  final _validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      value.trim().isNotEmpty ? sink.add(value) : sink.addError('Enter name');
    },
  );

  final _validateUsername = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      value.trim().length >= 4 ? sink.add(value) : sink.addError('Min 4 characters');
    },
  );

  final _validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.length == 10) {
        sink.add(value);
      } else {
        sink.addError('Enter 10-digit number');
      }
    },
  );

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      value.contains('@') ? sink.add(value) : sink.addError('Enter valid email');
    },
  );

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      value.length >= 6 ? sink.add(value) : sink.addError('Min 6 characters');
    },
  );

  // 🔥 Submit with Firebase
  Future<void> submit(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Registration Successful")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Registration Failed: ${e.toString()}")),
      );
    }
  }


  }
