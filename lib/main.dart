import 'package:bloc_login/features/screens/loginpage/bloc/login_bloc.dart';
import 'package:bloc_login/features/screens/registerpage/bloc/register_bloc.dart';
import 'package:bloc_login/features/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully");
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBloc>(create: (context) => RegisterBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "bloclogin",
        home: const SplashScreen(),
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
        ),

      ),
    );
  }
}
