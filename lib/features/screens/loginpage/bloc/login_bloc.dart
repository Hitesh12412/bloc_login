import 'dart:async';
import 'package:bloc_login/features/screens/home/ui/main_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';



class LoginBloc {
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  Stream<String> get loginEmail =>
      _emailController.stream.transform(_validateEmail);
  Stream<String> get loginPassword =>
      _passwordController.stream.transform(_validatePassword);
  Stream<bool> get submitValid =>
      CombineLatestStream.combine2(loginEmail, loginPassword, (a, b) => true);

  String _email = "";
  String _password = "";

  void changeLoginEmail(String value) {
    _email = value;
    _emailController.sink.add(value);
  }

  void changeLoginPassword(String value) {
    _password = value;
    _passwordController.sink.add(value);
  }

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError('Enter valid email');
      }
    },
  );

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6) {
        sink.add(password);
      } else {
        sink.addError('Password must be 6+ characters');
      }
    },
  );

  Future<void> submit(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Login Successful")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainHomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Login Failed: ${e.toString()}")),
      );
    }
  }

  }

