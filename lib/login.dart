import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});
  State<Login> createState() {
    return _LoginSate();
  }
}

class _LoginSate extends State<Login> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  void onpressed(BuildContext context) async {
    String enteredUsername = _usernamecontroller.text;
    String enteredPassword = _passwordcontroller.text;

    // Define the URL where you want to send the request
    final url = Uri.parse('<url>');

    // Create a Map representing the data you want to send
    final data = {
      'username': enteredUsername,
      'password': enteredPassword,
    };

    // Send the POST request
    final response = await http.post(url, body: data);

    // Check the response and handle accordingly
    if (response.statusCode == 200) {
      // Request was successful, do something with the response data
    } else {
      // Request failed, handle the error
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        const SizedBox(
          height: 300,
        ),
        Container(
            width: 300,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 0, 20),
                  child: TextField(
                    controller: _usernamecontroller,
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
                    controller: _passwordcontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                    autofocus: false,
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Login'))
              ],
            ))
      ]),
    );
  }
}
