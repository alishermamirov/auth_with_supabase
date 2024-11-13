import 'package:auth_with_supabase/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

enum AuthStatus {
  login,
  register,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthStatus authStatus = AuthStatus.login;

  void showToast(String message, ToastificationType type) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(message),
      alignment: Alignment.bottomCenter,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  void singUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      FocusScope.of(context).unfocus();
      await authService.signUpWithEmail(email, password);
      showToast("Success", ToastificationType.success);
    } catch (e) {
      showToast("Error ${e.toString()}", ToastificationType.error);
    }
  }

  void singIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      FocusScope.of(context).unfocus();
      await authService.signInWithEmail(email, password);
      showToast("Success", ToastificationType.success);
    } catch (e) {
      showToast("Error ${e.toString()}", ToastificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authStatus == AuthStatus.login ? "Login" : "Registration"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    showToast("Email or password is empty",
                        ToastificationType.warning);
                  } else {
                    if (authStatus == AuthStatus.login) {
                      singIn();
                    } else {
                      singUp();
                    }
                  }
                },
                child: Text(
                  authStatus == AuthStatus.login ? "Sign In" : "Sign Up",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (authStatus == AuthStatus.login) {
                    setState(() {
                      authStatus = AuthStatus.register;
                    });
                  } else {
                    setState(() {
                      authStatus = AuthStatus.login;
                    });
                  }
                },
                child: Text(authStatus == AuthStatus.login
                    ? "You don't have an account: Sign Up"
                    : "Login"))
          ],
        ),
      ),
    );
  }
}
