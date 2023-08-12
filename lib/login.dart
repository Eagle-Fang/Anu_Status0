import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  Login({super.key, this.Password, this.username});
  String? username;
  String? Password;
  State<Login> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  String _errorMessage = '';

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
        setState(() {
          _errorMessage = '';
        });
        // Navigator.push(
        //   context,
        // );
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response data: ${response.body}.');

        // Display error message for incorrect credentials
        setState(() {
          _errorMessage = 'Incorrect username or password';
        });
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          Container(
            width: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 0, 20),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Email',
                    ),
                    autofocus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 0, 10),
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                    autofocus: false,
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Login'),
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
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
