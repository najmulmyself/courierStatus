// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables

import 'package:courier_status/component/drawer_content.dart';
import 'package:courier_status/screens/shipment.dart';
import 'package:courier_status/screens/update_lot.dart';
import 'package:flutter/material.dart';

import '../Model/update_lot_model.dart';
import '../apiService/lot_status_view.dart';
import 'bulk_lot_update.dart';

class DashBoard extends StatelessWidget {
  final List dashData = [
    "Update Lot Status",
    "Bulk Lot Update",
    "Shipment",
    "Bulk Shipment",
  ];
  final List dashIcon = [
    Icons.stacked_bar_chart,
    Icons.security_update_good_outlined,
    Icons.local_shipping,
    Icons.shopping_cart_sharp,
  ];
  UpdateLotModel? dropdrownValue;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: Drawer(
          child: DrawerContent(),
        ),
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        // body: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
        //   child: GridView.builder(
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         mainAxisSpacing: 5,
        //         crossAxisCount: (Orientation == Orientation.portrait) ? 3 : 2),
        //     itemBuilder: (BuildContext context, index) {
        //       return Card(
        //         color: Colors.grey.shade300,
        //         elevation: 2,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Icon(
        //               dashIcon[index],
        //               size: 30,
        //             ),
        //             Text(
        //               dashData[index],
        // style: TextStyle(
        //   fontSize: 15,
        // ),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //     itemCount: dashData.length,
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // Update the state of the app.
                          // ...
                          dropdrownValue =
                              await ApiService().getUpdateStatusView();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateLotStatus(
                                data: dropdrownValue!.data,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 18,
                          ),
                          height: 200,
                          // width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey.shade300,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                dashIcon[0],
                                size: 30,
                              ),
                              Text(
                                dashData[0],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // Update the state of the app.
                          // ...
                          dropdrownValue =
                              await ApiService().getUpdateStatusView();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BulkLotUpdate(
                                data: dropdrownValue!.data,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          // margin: EdgeInsets.all(8),

                          height: 200,
                          // width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey.shade300,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                dashIcon[1],
                                size: 30,
                              ),
                              Text(
                                dashData[1],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // Update the state of the app.
                        // ...
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Shipment(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 18),
                        height: 200,
                        // width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              dashIcon[2],
                              size: 30,
                            ),
                            Text(
                              dashData[2],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // Update the state of the app.
                        // ...
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Shipment(),
                          ),
                        );
                      },
                      child: Container(
                        // margin: EdgeInsets.all(8),

                        height: 200,
                        // width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              dashIcon[3],
                              size: 30,
                            ),
                            Text(
                              dashData[3],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
