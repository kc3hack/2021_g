import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_box/baggage/box.dart';
import "package:smart_box/barcode_reader/BarcodeReader.dart";
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/ItemListWidget.dart';
import 'package:smart_box/ui/WidgetHolder.dart';

///
/// バーコード読み込みテスト用Widget
///
class QrScan extends StatefulWidget {
  final WidgetHolderState widgetHolderState;
  QrScan(this.widgetHolderState);
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  @override
  void initState() {
    super.initState();
    scanBarcode(ScanMode.QR).then((result) {
      List<String> r = result.split("/");
      getBoxes().then((boxes) {
        for (Box box in boxes) {
          if (box.id == int.parse(r.last)) {
            widget.widgetHolderState
                .add(ItemListWidget(box, widget.widgetHolderState));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("boxが見つかりませんでした"),
    );
  }
}
