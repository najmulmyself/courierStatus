// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:courier_status/screens/home_page.dart';
import 'package:flutter/material.dart';

import 'screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primarySwatch: Color(0xff950101),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xffFF0000),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomePage(),
      routes: {
        '/dashboard': (context) => DashBoard(),
      },
    );
  }
}
