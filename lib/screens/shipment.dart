// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:courier_status/Model/shipment_data_model.dart';
import 'package:courier_status/apiService/lot_status_view.dart';
import 'package:courier_status/screens/scan_code.dart';
import 'package:courier_status/screens/shipment_add_lot.dart';
import 'package:flutter/material.dart';

class Shipment extends StatefulWidget {
  const Shipment({Key? key}) : super(key: key);

  @override
  State<Shipment> createState() => _ShipmentState();
}

class _ShipmentState extends State<Shipment> {
  // ShipmentData? shipmentData;
  // Future<ShipmentData?> getShipmentData() async {
  //   shipmentData = await ApiService().getShipmentData();
  //   return shipmentData;
  // }

  // @override
  // void initState() {
  //   print("2shipmentData");

  //   super.initState();
  //   getShipmentData();

  // }

  @override
  Widget build(BuildContext context) {
    print("shipmentData");
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
                        primary: Color(0xff950101),
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
          FutureBuilder<ShipmentData?>(
            future: ApiService().getShipmentData(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showBottomBorder: true,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  columns: [
                    DataColumn(
                      label: Text("No"),
                    ),
                    DataColumn(
                      label: Text("Action"),
                    ),
                    DataColumn(
                      label: Text("Date"),
                    ),
                    DataColumn(
                      label: Text("Category"),
                    ),
                    DataColumn(
                      label: Text("Shipment No"),
                    ),
                  ],
                  rows: snapshot.hasData
                      ? snapshot.data!.data!
                          .map(
                            (e) => DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    // snapshot.data!.data!.length.toString(),
                                    "${snapshot.data!.data!.indexOf(e) + 1}",
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ShipmentAddLot(
                                                  id: e.id.toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            color: Colors.black38,
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          color: Colors.red,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                      "${e.startDate!.day}/${e.startDate!.month}/${e.startDate!.year}  - ${e.endDate!.day}/${e.endDate!.month}/${e.endDate!.year}"),
                                ),
                                DataCell(
                                  Text("${e.freightCategory}"),
                                ),
                                DataCell(
                                  Text(
                                    e.shipmentNumber.toString(),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList()
                      : [],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}



// DataRow(
//                   cells: [
//                     DataCell(Text('1')),
//                     DataCell(
//                       Center(
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 40,
//                               width: 40,
//                               color: Colors.black38,
//                               child: Icon(
//                                 Icons.edit,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               height: 40,
//                               width: 40,
//                               color: Colors.red,
//                               child: Icon(
//                                 Icons.delete,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     DataCell(Text('Active')),
//                     DataCell(Text('-')),
//                     DataCell(Text('-')),
//                   ],
//                 ),