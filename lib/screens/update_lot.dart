// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:courier_status/screens/scan_code.dart';
import 'package:flutter/material.dart';

import '../Model/update_lot_model.dart';

class UpdateLotStatus extends StatefulWidget {
  UpdateLotStatus({this.result, this.data});
  String? result;
  List<Datum>? data;

  @override
  State<UpdateLotStatus> createState() => _UpdateLotStatusState();
}

class _UpdateLotStatusState extends State<UpdateLotStatus> {
  String? newValue;
  List items = ['Under Processing China', 'Delivered Bangladesh'];

  // final dataDrop = widget.data.map((e) => )

  // final data = ApiService().getUpdateStatusView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Lot Status',
        ),
      ),
      body: Column(
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
                  initialValue: widget.result != '' ? widget.result : '',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reference Number',
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.camera_alt),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanCode()));
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
                      hint:
                          Text('Select Status'), // uNderprocessing - Bangladesh
                      items: widget.data!
                          .map(
                            (Datum e) => DropdownMenuItem(
                              child: Text("${e.name} - ${e.country!.name!}"),
                              value: newValue,
                            ),
                          )
                          .toList(),
                      // items: items
                      //     .map(
                      //       (e) => DropdownMenuItem(
                      //         child: Text(e),
                      //         value: e,
                      //       ),
                      //     )
                      //     .toList(),
                      onChanged: (value) {
                        setState(() {
                          newValue = value as String?;
                          print(newValue);
                        });
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff950101),
                      ),
                      onPressed: () {},
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
          // FutureBuilder<List<Data>?>(
          //   future: ApiService().getUpdateStatusView(),+
          //   builder: ((context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Center(
          //         child: Text("${snapshot.data![1].country!.name}"),
          //       );
          //     } else {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   }),
          // ),
        ],
      ),
    );
  }
}
