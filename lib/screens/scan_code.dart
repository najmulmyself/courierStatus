// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:courier_status/screens/dashboard.dart';
import 'package:courier_status/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanCode extends StatefulWidget {
  ScanCode({this.isBulk = false});
  bool? isBulk;
  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  String newResult = '';
  QRViewController? controller;

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
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
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
                                widget.isBulk! == true
                                    ? ElevatedButton(
                                        onPressed: () {
                                          dynamic data = result!.code;
                                          dynamic dataCommaSplit =
                                              data.split(",");
                                          dynamic refData = dataCommaSplit[0];
                                          dynamic refDataSplit =
                                              refData.split(":");
                                          newResult = refDataSplit[1];
                                          widget.isBulk! == true
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ScanCode(
                                                      isBulk: true,
                                                    ),
                                                  ),
                                                )
                                              : Navigator.pop(
                                                  context, newResult);
                                        },
                                        child: Text("Scan more"),
                                      )
                                    : Container(),
                                ElevatedButton(
                                  onPressed: () {
                                    dynamic data = result!.code;
                                    dynamic dataCommaSplit = data.split(",");
                                    dynamic refData = dataCommaSplit[0];
                                    dynamic refDataSplit = refData.split(":");
                                    newResult = refDataSplit[1];
                                    widget.isBulk! == true
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DashBoard(),
                                            ),
                                          )
                                        : Navigator.pop(context, newResult);
                                  },
                                  child: widget.isBulk! == true
                                      ? Text("Go to Homepage")
                                      : Text("Done"),
                                ),
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
                      )),
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
