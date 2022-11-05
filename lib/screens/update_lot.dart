// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class UpdateLotStatus extends StatelessWidget {
  const UpdateLotStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Lot Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Update Lot Status"),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Reference Number',
                suffixIcon: Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
