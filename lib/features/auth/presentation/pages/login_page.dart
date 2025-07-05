import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_chat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_chat/features/auth/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;

  void onVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 8),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              controller: passwordController,
              obscureText: isVisible,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: GestureDetector(
                  onTap: onVisible,
                  child: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                LoginEvent(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                ),
              );
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                }
                return Text("Login");
              },
            ),
          ),
          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "Don't have account? "),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(color: Colors.blue.shade800),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
