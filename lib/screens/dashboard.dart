// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables

import 'package:courier_status/component/drawer_content.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  final List dashData = [
    "Lot",
    "Bookings",
    "Location",
    "Location-Status",
    "Product",
    "Activity",
    "Activity-Status",
    "Help",
  ];
  final List dashIcon = [
    Icons.local_shipping,
    Icons.book,
    Icons.location_on,
    Icons.location_on,
    Icons.shopping_cart,
    Icons.local_activity,
    Icons.local_activity,
    Icons.help,
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          drawer: Drawer(
            child: DrawerContent(),
          ),
          appBar: AppBar(
            title: Text('Dashboard'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisCount:
                      (Orientation == Orientation.portrait) ? 3 : 2),
              itemBuilder: (BuildContext context, index) {
                return Card(
                  color: Colors.grey.shade200,
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        dashIcon[index],
                        size: 30,
                      ),
                      Text(dashData[index],
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ],
                  ),
                );
              },
              itemCount: 8,
            ),
          )),
    );
  }
}
