// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:courier_status/Model/update_lot_model.dart';
import 'package:courier_status/apiService/lot_status_view.dart';
import 'package:courier_status/screens/shipment.dart';
import 'package:courier_status/screens/sign_in_page.dart';
import 'package:flutter/material.dart';

import '../screens/update_lot.dart';

class DrawerContent extends StatelessWidget {
  UpdateLotModel? dropdrownValue;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Image(
            image: AssetImage('assets/images/logo.png'),
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
          ),
        ),
        Center(
          child: ListTile(
            leading: Icon(
              Icons.stacked_bar_chart,
              color: Colors.black,
            ),
            title: Text('Update lot status'),
            onTap: () async {
              // Update the state of the app.
              // ...
              dropdrownValue = await ApiService().getUpdateStatusView();
              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateLotStatus(
                            data: dropdrownValue!.data,
                          )));
            },
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.local_shipping,
            color: Colors.black,
          ),
          title: Text('Shipments'),
          onTap: () {
            // Update the state of the app.
            // ...
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Shipment(),
              ),
            );
          },
        ),
        Center(
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text('Profile'),
            onTap: () {
              // Update the state of the app.
              // // ...
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => UpdateLotStatus()));
            },
          ),
        ),
        Center(
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text('Sign out'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                  (route) => false);
            },
          ),
        ),
      ],
    );
  }
}
