// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:courier_status/Model/shipment_lot-view_model.dart';
import 'package:courier_status/Model/update_status_model.dart';
import 'package:courier_status/apiService/lot_status_view.dart';
import 'package:courier_status/screens/scan_code.dart';
import 'package:flutter/material.dart';
import '../Model/update_lot_model.dart';

class ShipmentAddLot extends StatefulWidget {
  ShipmentAddLot({this.result, this.data, this.id});

  String? result = '';
  List<Datum>? data;

  // shipment data

  String? id;

  @override
  State<ShipmentAddLot> createState() => _ShipmentAddLotState();
}

class _ShipmentAddLotState extends State<ShipmentAddLot> {
  Datum? newValue;
  int? indexId;
  UpdateStatus? updateStatusData;
  Function? onFail;

  TextEditingController refCodeController = TextEditingController();

  List<DataCell>? listRow = [
    DataCell(Text("-")),
    DataCell(Text("-")),
    DataCell(Text("-")),
  ];

  Future<UpdateStatus> getUpdateDatabyId() async {
    return updateStatusData = await ApiService()
        .updateStatus(indexId, refCodeController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Lots',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Lots",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    initialValue: widget.result,
                    controller: refCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Reference Number',
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.camera_alt),
                        onTap: () async {
                          var scanResult = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScanCode()));

                          // print("result-ashif: ${scanResult.toString()}");

                          if (scanResult != null) {
                            refCodeController.text = scanResult.toString();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // back: Color(0xff950101),
                        // backgroundColor: Color(0xff950101),
                        primary: Color(0xff950101),
                      ),
                      onPressed: () {
                        print(refCodeController.text);
                        ApiService().addLotViewDataWithRef(
                            widget.id, refCodeController.text);
                      },
                      child: Text("Add"),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Lot>?>(
              future: ApiService().getLotViewData(widget.id),
              builder: (context, snapshot) {
                print("{snapshot.data} : ${snapshot.data}");
                print("snapshot.error : ${snapshot.error}");
                return snapshot.data != null
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          sortAscending: true,
                          sortColumnIndex: 0,
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
                          rows: snapshot.hasData
                              ? snapshot.data!
                                  .map(
                                    (e) => DataRow(
                                      cells: [
                                        DataCell(Text("${e.reference}")),
                                        DataCell(Text("${e.id}")),
                                        DataCell(Text("${e.booking}")),
                                      ],
                                    ),
                                  )
                                  .toList()
                              : [
                                  // DataRow(
                                  //   cells: [
                                  //     DataCell(Text("-")),
                                  //     DataCell(Text("-")),
                                  //     DataCell(Text("-")),
                                  //   ],
                                  // ),
                                ],
                        ),
                      )
                    : CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
