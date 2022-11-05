// ignore_for_file: prefer_const_constructors

import 'package:courier_status/screens/home_page.dart';
import 'package:flutter/material.dart';

import 'screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomePage(),
      routes: {
        '/dashboard': (context) => DashBoard(),
      },
    );
  }
}
