// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:courier_status/screens/dashboard.dart';
import 'package:courier_status/screens/home_page.dart';
import 'package:courier_status/screens/shipment.dart';
import 'package:courier_status/screens/shipment_add_lot.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../Model/update_status_model.dart';
import '../apiService/lot_status_view.dart';

class ScanCode extends StatefulWidget {
  ScanCode({
    this.isUpdateLotBulk = false,
    this.isShipmentBulk,
    this.id = 0,
    this.shipmentId = '',
  });
  bool? isUpdateLotBulk;
  bool? isShipmentBulk;
  int? id;
  String? shipmentId;
  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  UpdateStatus? updateStatusData;
  UpdateStatus? shipmentUpdateStatusData;
  String newResult = '';
  QRViewController? controller;

  Future<UpdateStatus> getUpdateDatabyId() async {
    return updateStatusData =
        await ApiService().updateStatus(widget.id, newResult.toString());
  }

  // ShipmentBulk

  Future<UpdateStatus> testupdate(id, ref) async {
    return shipmentUpdateStatusData =
        await ApiService().addLotViewDataWithRef(id, ref);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code'), actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DashBoard()));
          },
          icon: Icon(Icons.home),
        ),
      ]),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${result!.code}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Bor Update Lot Bulk - Scan More

                              widget.isUpdateLotBulk! == true
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        // this part is for refNumber
                                        dynamic data = result!.code;
                                        dynamic dataCommaSplit =
                                            data.split(",");
                                        dynamic refData = dataCommaSplit[0];
                                        dynamic refDataSplit =
                                            refData.split(":");
                                        newResult = refDataSplit[1];
                                        if (widget.id! > 0) {
                                          //  widget.id! > 0
                                          //     ? getUpdateDatabyId()
                                          //     : null;

                                          UpdateStatus successUpdate =
                                              await getUpdateDatabyId();

                                          if (successUpdate
                                                  .responseStatusCode ==
                                              200) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text("Status Updated"),
                                              ),
                                            );
                                          }
                                        }
                                        widget.isUpdateLotBulk! == true
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScanCode(
                                                    isUpdateLotBulk: true,
                                                    id: widget.id,
                                                  ),
                                                ),
                                              )
                                            : Navigator.pop(context, newResult);
                                      },
                                      child: Text("Scan more"),
                                    )
                                  : Container(),

                              //For Update Lot Bulk - Homepage or Done
                              widget.isUpdateLotBulk == true
                                  ? ElevatedButton(
                                      onPressed: () {
                                        dynamic data = result!.code;
                                        dynamic dataCommaSplit =
                                            data.split(",");
                                        dynamic refData = dataCommaSplit[0];
                                        dynamic refDataSplit =
                                            refData.split(":");
                                        newResult = refDataSplit[1];
                                        widget.id! > 0
                                            ? getUpdateDatabyId()
                                            : null;
                                        widget.isUpdateLotBulk! == true
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashBoard(),
                                                ),
                                              )
                                            : Navigator.pop(context, newResult);
                                      },
                                      child: widget.isUpdateLotBulk! == true
                                          ? Text("Go to Homepage")
                                          : Text("Done"),
                                    )
                                  : Container(),

                              //For Bulk Shipment - Scan More
                              widget.isShipmentBulk == true
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        // this part is for refNumber
                                        dynamic data = result!.code;
                                        dynamic dataCommaSplit =
                                            data.split(",");
                                        dynamic refData = dataCommaSplit[0];
                                        dynamic refDataSplit =
                                            refData.split(":");
                                        newResult = refDataSplit[1];
                                        // if (widget.id! > 0) {
                                        //   //  widget.id! > 0
                                        //   //     ? getUpdateDatabyId()
                                        //   //     : null;

                                        //   UpdateStatus successUpdate =
                                        //       await getUpdateDatabyId();

                                        ApiService()
                                            .addLotViewDataWithRef(
                                                widget.shipmentId, newResult)
                                            .then((value) {
                                          if (value != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    "Successfully Updated"),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text("Already Added"),
                                              ),
                                            );
                                          }
                                        });
                                        // .catchError((error, stackTrace) =>
                                        //         ScaffoldMessenger.of(context)
                                        //             .showSnackBar(SnackBar(
                                        //           content:
                                        //               Text(error.toString()),
                                        //           backgroundColor: Colors.red,
                                        //         )));

                                        // if (successUpdate.responseStatusCode ==
                                        //     200) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(
                                        //     SnackBar(
                                        //       backgroundColor: Colors.green,
                                        //       content: Text("Status Updated"),
                                        //     ),
                                        //   );
                                        // }
                                        // }
                                        widget.isShipmentBulk! == true
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScanCode(
                                                    isShipmentBulk: true,
                                                    shipmentId:
                                                        widget.shipmentId,
                                                  ),
                                                ),
                                              )
                                            : Navigator.pop(context, newResult);
                                      },
                                      child: Text("Scan more"),
                                    )
                                  : Container(),
                              //For Shipment Bulk - Done or Homepage

                              widget.isShipmentBulk == true
                                  ? ElevatedButton(
                                      onPressed: () {
                                        dynamic data = result!.code;
                                        dynamic dataCommaSplit =
                                            data.split(",");
                                        dynamic refData = dataCommaSplit[0];
                                        dynamic refDataSplit =
                                            refData.split(":");
                                        newResult = refDataSplit[1];
                                        // widget.id! > 0
                                        //     ? getUpdateDatabyId()
                                        //     : null;
                                        // addLotViewDataWithRef(id, ref)@
                                        ApiService()
                                            .addLotViewDataWithRef(
                                                widget.shipmentId, newResult)
                                            .then((value) {
                                          if (value != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    "Successfully Updated"),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text("Already Added"),
                                              ),
                                            );
                                          }
                                        });
                                        widget.isShipmentBulk! == true
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashBoard(),
                                                ),
                                              )
                                            : Navigator.pop(context, newResult);
                                      },
                                      child: widget.isShipmentBulk! == true
                                          ? Text("Go to Homepage")
                                          : Text("Done"),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Text(
                      "Scanning...",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
