//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  State<GetStarted> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<GetStarted> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final storage = FlutterSecureStorage();

  //String _errorMessage = '';

  Future<void> onPressed() async {
    var url = Uri.http('10.50.6.191:5000', '/login');
    final Map<String, dynamic> jsonData = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jsonData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        var itemCount = jsonResponse['totalItems'];
        print('Number of items: $itemCount.');

        // Store tokens
        String accessToken = jsonResponse['access_token'];
        String refreshToken = jsonResponse['refresh_token'];
        await storage.write(key: 'access_token', value: accessToken);
        await storage.write(key: 'refresh_token', value: refreshToken);

        print('Access Token: $accessToken');
        print('Refresh Token: $refreshToken');

        // Clear any previous error message

        // Navigator.push(
        //   context,
        // );
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  Future<void> _signUp() async {
    final String apiUrl =
        "http://10.50.6.191:5000/signup"; // Update with your actual URL

    final Map<String, dynamic> signupData = {
      "username": _usernameController.text,
      "password": _passwordController.text,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(signupData),
    );

    print("Signup Response:");
    print("Status Code: ${response.statusCode}");
    print("Response JSON: ${response.body}");
    onPressed();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              'Signup',
              style: TextStyle(
                  fontSize: 50, fontWeight: FontWeight.bold, letterSpacing: 4),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(29, 0, 0, 0),
            child: Text('Hello,Enter your email to continue'),
          ),
          Container(
            child: Column(children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Email',
                ),
                autofocus: false,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passwordl',
                  hintText: 'Password',
                ),
                autofocus: false,
              ),
              TextButton(onPressed: _signUp, child: const Text('Signup'))
            ]),
          )
        ],
      ),
    );
  }
}
