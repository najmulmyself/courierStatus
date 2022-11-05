// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Shipment extends StatelessWidget {
  const Shipment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipment'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipment List"),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade800,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.add_box_rounded),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Create"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showBottomBorder: true,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              columns: [
                DataColumn(
                  label: Text("Reference"),
                ),
                DataColumn(
                  label: Text("Location Status"),
                ),
                DataColumn(
                  label: Text("Lots of"),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Active')),
                    DataCell(Text('-')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
