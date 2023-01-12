import 'package:flutter/material.dart';

import '../Model/shipment_data_model.dart';

class BulkLotUpdate extends StatefulWidget {
  const BulkLotUpdate({super.key});

  @override
  State<BulkLotUpdate> createState() => _BulkLotUpdateState();
}

class _BulkLotUpdateState extends State<BulkLotUpdate> {
  Datum? newValue;
  String? result = '';
  List<Datum>? data;
  int? indexId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton(
                    isExpanded: true,
                    value: newValue,
                    hint: Text('Select Status'), // uNderprocessing - Bangladesh
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
      ],
    );
  }
}