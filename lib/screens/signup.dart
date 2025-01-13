import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:products/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email = "";
  String? _name = "";
  String _password = "";

  Future<void> _signup() async {
    if (_email.isEmpty || _password.isEmpty) {
      Get.snackbar("Field", "Email and Password Fields are required");
      return;
    }

    var res = await http.post(
        Uri.parse(
            "https://flutter-test-server.onrender.com/api/users/register"),
        body:
            jsonEncode({'name': _name, 'email': _email, 'password': _password}),
        headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 201) {
      Get.snackbar("User", "Registered successfully");
      Get.to(Login());
    } else {
      Get.snackbar("Error", "Try Again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.mail),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.key),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "SIGNUP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Get.to(Login());
                },
                child: const Text("already have account login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
