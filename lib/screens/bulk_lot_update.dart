import 'package:courier_status/Model/update_lot_model.dart';
import 'package:courier_status/screens/scan_code.dart';
import 'package:flutter/material.dart';

import '../Model/update_status_model.dart';

class BulkLotUpdate extends StatefulWidget {
  BulkLotUpdate({this.data});

  List<Datum>? data;
  @override
  State<BulkLotUpdate> createState() => _BulkLotUpdateState();
}

class _BulkLotUpdateState extends State<BulkLotUpdate> {
  Datum? newValue;
  String? result = '';
  int? indexId;

  List<DataCell>? listRow = [
    DataCell(Text("-")),
    DataCell(Text("-")),
    DataCell(Text("-")),
  ];

  List<UpdateStatus> dataRow = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bulk Lot Update',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<Datum>(
              isExpanded: true,
              value: newValue,
              hint: const Text('Select Status'), // uNderprocessing - Bangladesh
              items: widget.data!.map(
                (Datum item) {
                  return DropdownMenuItem<Datum>(
                    child: Text(
                      "${item.name} - ${item.country!.name!} ",
                      style: TextStyle(
                          // overflow: TextOverflow.fade,
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // back: Color(0xff950101),
                  // backgroundColor: Color(0xff950101),
                  primary: Color(0xff950101),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanCode(isBulk: true, id: indexId),
                    ),
                  );
                }
                // () async {
                // UpdateStatus dataContent = await getUpdateDatabyId();
                // print("messege: ${updateStatusData?.message}");
                // print("code: ${updateStatusData?.responseStatusCode}");
                // print(dataContent.responseStatusCode);

                // if (dataContent.responseStatusCode == 200) {
                //   setState(() {
                //     dataRow.add(dataContent);
                //   });
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       backgroundColor: Colors.red,
                //       content: Text(
                //         dataContent.message.toString(),
                //       ),
                //     ),
                //   );
                // }

                ,
                child: Text("Scan Code"),
              ),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: DataTable(
            //     sortAscending: true,
            //     sortColumnIndex: 0,
            //     showBottomBorder: true,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.grey.shade300),
            //     ),
            //     columns: const [
            //       DataColumn(
            //         label: Text("Reference"),
            //       ),
            //       DataColumn(
            //         label: Text("Location Status"),
            //       ),
            //       DataColumn(
            //         label: Text("Lots of"),
            //       ),
            //     ],
            //     rows: dataRow.isNotEmpty
            //         ? dataRow
            //             .map(
            //               (e) => DataRow(
            //                 cells: [
            //                   DataCell(
            //                     Text("${e.data?.reference.toString()}"),
            //                   ),
            //                   DataCell(
            //                     Text("${e.data?.locationStatus}"),
            //                   ),
            //                   DataCell(
            //                     Text("${e.data?.booking}"),
            //                   ),
            //                 ],
            //               ),
            //             )
            //             .toList()
            //         : [
            //             DataRow(
            //               cells: [
            //                 DataCell(
            //                   Text("-"),
            //                 ),
            //                 DataCell(
            //                   Text("-"),
            //                 ),
            //                 DataCell(
            //                   Text("-"),
            //                 ),
            //               ],
            //             ),
            //           ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
