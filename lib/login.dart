import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  State<Login> createState() {
    return _loginSate();
  }
}

class _loginSate extends State<Login> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        const SizedBox(
          height: 300,
        )
      ]),
    );
  }
}
