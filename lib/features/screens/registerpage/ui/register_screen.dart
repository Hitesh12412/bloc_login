import 'package:bloc_login/features/screens/loginpage/ui/login_screen.dart';
import 'package:bloc_login/features/screens/registerpage/bloc/register_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  bool isVisible = false;

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _circleLeftAnimation;
  late Animation<Offset> _circleRightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _circleLeftAnimation = Tween<Offset>(
      begin: const Offset(-0.2, -0.2), // slide from top-left
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _circleRightAnimation = Tween<Offset>(
      begin: const Offset(0.25, -0.15), // slide from top-right
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  InputDecoration _filledBlueDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.blue.shade100,
      prefixIcon: Icon(icon, color: Colors.blue),
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Back to sign in",
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: SlideTransition(
                position: _circleLeftAnimation,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: -60,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: SlideTransition(
                position: _circleRightAnimation,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: 24 + MediaQuery.of(context).viewInsets.bottom),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Lottie.asset(
                          'assets/animations/Login.json',
                          width: 300,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 10),
                        StreamBuilder(
                          stream: bloc.name,
                          builder: (context, snapshot) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: TextField(
                                keyboardType: TextInputType.name,
                                decoration: _filledBlueDecoration(
                                  hint: "Name",
                                  label: "Name",
                                  icon: Icons.abc_sharp,
                                ).copyWith(
                                    errorText: snapshot.error?.toString()),
                                onChanged: bloc.changeName,
                              ),
                            );
                          },
                        ),
                        StreamBuilder(
                          stream: bloc.username,
                          builder: (context, snapshot) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                decoration: _filledBlueDecoration(
                                  hint: "Username",
                                  label: "Username",
                                  icon: Icons.abc,
                                ).copyWith(
                                    errorText: snapshot.error?.toString()),
                                onChanged: bloc.changeUsername,
                              ),
                            );
                          },
                        ),
                        StreamBuilder(
                          stream: bloc.phone,
                          builder: (context, snapshot) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                decoration: _filledBlueDecoration(
                                  hint: "Phone",
                                  label: "Phone",
                                  icon: Icons.phone_android,
                                ).copyWith(
                                    errorText: snapshot.error?.toString()),
                                onChanged: bloc.changePhone,
                              ),
                            );
                          },
                        ),
                        StreamBuilder(
                          stream: bloc.email,
                          builder: (context, snapshot) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: _filledBlueDecoration(
                                  hint: "Email",
                                  label: "Email",
                                  icon: Icons.email,
                                ).copyWith(
                                    errorText: snapshot.error?.toString()),
                                onChanged: bloc.changeEmail,
                              ),
                            );
                          },
                        ),
                        StreamBuilder(
                          stream: bloc.password,
                          builder: (context, snapshot) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: TextField(
                                obscureText: !isVisible,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: _filledBlueDecoration(
                                  hint: "Password",
                                  label: "Password",
                                  icon: Icons.password,
                                ).copyWith(
                                  errorText: snapshot.error?.toString(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                  ),
                                ),
                                onChanged: bloc.changePassword,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildRegisterButton(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
                    bloc.submit(context);
                  },
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.blue,
              ),
              child: const Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
