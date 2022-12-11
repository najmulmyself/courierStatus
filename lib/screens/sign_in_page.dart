// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:courier_status/apiService/setToken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final url = Uri.parse('http://13.228.51.39:1337/api/token/');
  Future<void> signIn(context) async {
    try {
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
        SetToken().setToken(accToken);
        print(data['access']);
        Navigator.pushNamed(context, '/dashboard');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Sign in Successful'),
          ),
        );
        emailController.clear();
        passwordController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Wrong Email or Password'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", height: 120),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
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
              obscureText: true,
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
              style: ElevatedButton.styleFrom(
                primary: Color(0xff950101),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                signIn(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
