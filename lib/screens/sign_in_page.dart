// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final url = Uri.parse('http://13.214.104.111:1337/api/token/');
  Future<void> signIn(context) async {
    final response = await http.post(
      url,
      body: {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );
    print("Sign in Happend${response.statusCode} ");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accToken = data['access'];
      print(data['access']);
      Navigator.pushNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your email address',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your password',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              signIn(context);
              // Navigator.pushNamed(context, '/dashboard');
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
