// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import '../screens/update_lot.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text('Courier'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        Center(
          child: ListTile(
            leading: Icon(Icons.stacked_bar_chart),
            title: Text('Update lot status'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateLotStatus()));
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.local_shipping),
          title: Text('Shipments'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    );
  }
}
