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

  TextEditingController refCodeController = TextEditingController();

  List<DataCell>? listRow = [
    DataCell(Text("-")),
    DataCell(Text("-")),
    DataCell(Text("-")),
  ];

  List<UpdateStatus> dataRow = [];

  @override
  void initState() {
    // newValue = widget.data![0];
    // print("Hello restult ${widget.result.toString()}");
    super.initState();
  }

  Future<UpdateStatus> getUpdateDatabyId() async {
    // print(" Id and refcode : ${indexId} and ${widget.result}");
    // print("Hello restult ${updateStatusData?.data?.locationStatus}");
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
                    // onChanged: (value) {
                    //   setState(() {
                    //     widget.result = value.toString();
                    //   });
                    // },
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

                          print("result-ashif: ${scanResult.toString()}");

                          if (scanResult != null) {
                            refCodeController.text = scanResult.toString();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        value: newValue,
                        hint: Text(
                            'Select Status'), // uNderprocessing - Bangladesh
                        items: widget.data!.map(
                          (Datum item) {
                            return DropdownMenuItem<Datum>(
                              child: Text(
                                  "${item.name} - ${item.country!.name!} "),
                              value: item,
                            );
                          },
                        ).toList(),
                        onChanged: (Datum? v) {
                          setState(() {
                            newValue = v;
                            indexId = v?.id;
                            // print("Hello: $index  and ${v?.id}");
                          });
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff950101),
                        ),
                        onPressed: () async {
                          // ApiService().updateStatus(indexId, widget.result);
                          UpdateStatus dataContent = await getUpdateDatabyId();
                          setState(() {
                            // if(dataRow.contains(dataContent.data!.reference  ))

                            // if (dataRow.isNotEmpty) {
                            // for (int i = 0; i < dataRow.length; i++) {
                            //   print(
                            //       "rrrrrrrrrrrrrrrrr ${dataRow[i].data!.reference}");
                            //   print(i);
                            //   print(
                            //       "sssssssssssssssss ${dataContent.data!.reference}");
                            //   if (dataRow[i].data!.reference ==
                            //       dataContent.data!.reference) {
                            //     setState(() {
                            //       dataRow.removeAt(dataRow.indexWhere(
                            //           (element) =>
                            //               element.data!.reference ==
                            //               dataContent.data!.reference));
                            //       dataRow.add(dataContent);
                            //     });
                            //   } else {
                            //     dataRow.add(dataContent);
                            //   }
                            // }

                            //   if ((dataRow.singleWhere(
                            //           (it) =>
                            //               it.data!.reference ==
                            //               dataContent.data!.reference,
                            //           orElse: () {
                            //         return dataContent;
                            //       })) !=
                            //       null) {
                            //     setState(() {
                            //       dataRow.removeAt(dataRow.indexWhere((element) =>
                            //           element.data!.reference ==
                            //           dataContent.data!.reference));
                            //       dataRow.add(dataContent);
                            //     });
                            //   } else {
                            //     setState(() {
                            //       dataRow.add(dataContent);
                            //     });
                            //     print('Added!');
                            //   }
                            // } else {
                            // }
                            // refCodeController.text = '';
                            dataRow.add(dataContent);
                          });
                        },
                        child: Text("Update"),
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
                // rows: [
                //   updateStatusData?.data != null
                //       ?
                //       DataRow(
                //           cells: [
                //             DataCell(Text(
                //                 "${updateStatusData?.data?.reference.toString()}")),
                //             DataCell(Text(
                //                 "${updateStatusData?.data?.locationStatus}")),
                //             DataCell(Text("${updateStatusData?.data?.booking}")),
                //           ],
                //         )
                //       : DataRow(
                //           cells: listRow!,
                //         ),
                //   // DataRow(
                //   //   cells: [
                //   //     DataCell(Text(
                //   //         "${updateStatusData?.data?.reference.toString()}")),
                //   //     DataCell(Text("${updateStatusData?.data?.locationStatus}")),
                //   //     DataCell(Text("${updateStatusData?.data?.booking}")),
                //   //   ],
                //   // )
                // ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
