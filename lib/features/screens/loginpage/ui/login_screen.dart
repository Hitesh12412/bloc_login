import 'package:bloc_login/features/screens/registerpage/ui/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Forget Password?',
              style: TextStyle(color: Colors.blue, fontSize: 16),
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
                position: Tween<Offset>(
                  begin: const Offset(-0.2, -0.2),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack)),
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
                position: Tween<Offset>(
                  begin: const Offset(0.25, -0.15),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack)),
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
                padding: EdgeInsets.only(bottom: 24 + MediaQuery.of(context).viewInsets.bottom),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Lottie.asset(
                          'assets/animations/Login_Leady.json',
                          width: 300,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        StreamBuilder(
                          stream: bloc.loginEmail,
                          builder: (context, snapshot) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.blue.shade100,
                                  prefixIcon: const Icon(Icons.email, color: Colors.blue),
                                  hintText: "Email",
                                  hintStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelText: "Email",
                                  labelStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorText: snapshot.error?.toString(),
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
                                ),
                                onChanged: (value) => bloc.changeLoginEmail(value),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        StreamBuilder(
                          stream: bloc.loginPassword,
                          builder: (context, snapshot) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              child: TextField(
                                obscureText: !isVisible ? true : false,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.blue.shade100,
                                  prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    icon: isVisible
                                        ? const Icon(Icons.visibility, color: Colors.blue)
                                        : const Icon(Icons.visibility_off, color: Colors.blue),
                                    onPressed: () => setState(() => isVisible = !isVisible),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelText: "Password",
                                  labelStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorText: snapshot.error?.toString(),
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
                                ),
                                onChanged: (value) => bloc.changeLoginPassword(value),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        _buildLoginButton(),
                        const SizedBox(height: 16),
                        Text(
                          "Don't have an account ?",
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                        GestureDetector(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Sign Up from here",
                                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const RegisterScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasError || !snapshot.hasData ? null : () {
              bloc.submit(context);
            },
            child: AnimatedContainer(
              padding: const EdgeInsets.all(16),
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
