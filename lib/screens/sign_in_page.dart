// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  void accessToken(){
    http
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your email address',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
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
              Navigator.pushNamed(context, '/dashboard');
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
