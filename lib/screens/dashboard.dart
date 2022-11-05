// ignore_for_file: prefer_const_constructors

import 'package:courier_status/component/drawer_content.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: DrawerContent(),),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
