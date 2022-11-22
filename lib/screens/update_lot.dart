// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:courier_status/Model/update_status_model.dart';
import 'package:courier_status/apiService/lot_status_view.dart';
import 'package:courier_status/screens/scan_code.dart';
import 'package:flutter/material.dart';
import '../Model/update_lot_model.dart';

class UpdateLotStatus extends StatefulWidget {
  UpdateLotStatus({this.result, this.data});

  String? result = '';
  List<Datum>? data;

  @override
  State<UpdateLotStatus> createState() => _UpdateLotStatusState();
}

class _UpdateLotStatusState extends State<UpdateLotStatus> {
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

  List<UpdateStatus> dataRow = [];

  @override
  void initState() {
    super.initState();
  }

  Future<UpdateStatus> getUpdateDatabyId() async {
    return updateStatusData = await ApiService()
        .updateStatus(indexId, refCodeController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Lot Status',
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
                    "Update Lot Status",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton(
                        value: newValue,
                        hint: Text(
                            'Select Status'), // uNderprocessing - Bangladesh
                        items: widget.data!.map(
                          (Datum item) {
                            return DropdownMenuItem<Datum>(
                              child: Text(
                                "${item.name} - ${item.country!.name!} ",
                                style: TextStyle(
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              value: item,
                            );
                          },
                        ).toList(),
                        onChanged: (Datum? v) {
                          setState(() {
                            newValue = v;
                            indexId = v?.id;
                          });
                        },
                      ),
                      Expanded(
                        child: Container(
                          width: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // back: Color(0xff950101),
                              // backgroundColor: Color(0xff950101),
                              primary: Color(0xff950101),
                            ),
                            onPressed: () async {
                              UpdateStatus dataContent =
                                  await getUpdateDatabyId();
                              print("messege: ${updateStatusData?.message}");
                              print(
                                  "code: ${updateStatusData?.responseStatusCode}");
                              print(dataContent.responseStatusCode);

                              if (dataContent.responseStatusCode == 200) {
                                setState(() {
                                  dataRow.add(dataContent);
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content:
                                        Text(dataContent.message.toString()),
                                  ),
                                );
                              }
                            },
                            child: Text("Update"),
                          ),
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
                rows: dataRow.isNotEmpty
                    ? dataRow
                        .map((e) => DataRow(
                              cells: [
                                DataCell(
                                    Text("${e.data?.reference.toString()}")),
                                DataCell(Text("${e.data?.locationStatus}")),
                                DataCell(Text("${e.data?.booking}")),
                              ],
                            ))
                        .toList()
                    : [
                        DataRow(cells: [
                          DataCell(Text("-")),
                          DataCell(Text("-")),
                          DataCell(Text("-")),
                        ])
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
