import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:products/controllers/authController.dart';
import 'package:products/layout.dart';
import 'package:products/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = "";
  String _password = "";
  AuthController auth = Get.find<AuthController>();

  Future<void> _login() async {
    if (_email.isEmpty || _password.isEmpty) {
      Get.snackbar(
          "Field are required", "Email and Password Fields are required");
      return;
    }

    final url =
        Uri.parse("https://flutter-test-server.onrender.com/api/users/login");
    final response = await http.post(url,
        body: jsonEncode({'email': _email, 'password': _password}),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      auth.setToken(data['token']);
      Get.to(Layout());
    } else {
      Get.snackbar("Error", "Error while login");
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
                    labelText: "Email",
                    prefixIcon: Icon(Icons.mail),
                    hintText: "Enter Your Email"),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.key),
                    hintText: "Enter Your Password"),
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
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "LOGIN",
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
                  Get.to(Signup());
                },
                child: const Text("don't have account sign up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
