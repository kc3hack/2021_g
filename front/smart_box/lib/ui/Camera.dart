import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import "package:smart_box/barcode_reader/BarcodeReader.dart";

///
/// バーコード読み込みテスト用Widget
///
class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  String _scanResult = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () => {
                    scanBarcode("#ff6666",ScanMode.BARCODE).then((result) => {
                      setState(() => {_scanResult = result})
                    })
                  },
                  child: Text("Start barcode scan")),
              ElevatedButton(
                  onPressed: () => {
                    scanBarcode("#ff6666",ScanMode.QR).then((result) => {
                      setState(() => {_scanResult = result})
                    })
                  },
                  child: Text("Start QR scan")),
              Text('Scan result : $_scanResult\n',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)))
            ]));
  }
}