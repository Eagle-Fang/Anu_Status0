import 'package:flutter/material.dart';

class Intropage extends StatelessWidget {
  const Intropage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        const SizedBox(
          height: 200,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Recyclic",
              style: TextStyle(fontSize: 30, letterSpacing: 4),
            ),
            // const SizedBox(
            //   height: 300,
            // ),
          ],
        ),
        const SizedBox(
          height: 500,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Colors.black),
              padding:
                  const EdgeInsets.symmetric(vertical: 13, horizontal: 120),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 0),
          child: const Text(
            "Get Started",
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(
              width: 120,
            ),
            const Text("ALready Have an Account?"),
            TextButton(onPressed: () {}, child: const Text("Login"))
          ],
        )
      ]),
    );
  }
}
