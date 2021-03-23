import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_box/StringUtility/StringUtility.dart';
import 'package:smart_box/baggage/box.dart';
import "package:smart_box/barcode_reader/BarcodeReader.dart";
import 'package:smart_box/ui/ItemListWidget.dart';
import 'package:smart_box/ui/WidgetHolder.dart';

///
/// 「よみとる」の動作を定義するクラス
///
class QrScan {
  static bool isQrScan = false;
  static Future<void> scanQr(WidgetHolderState widgetHolderState) async {
    if (isQrScan) return;
    isQrScan = true;
    Box aBox;
    String qrString = await scanBarcode(ScanMode.QR);
    if (validateQrString(qrString)) {
      aBox = await getBoxFromQrLink(qrString);
    }
    if (aBox == null) {
      widgetHolderState.startNewWidget(Container(
        child: Text("ボックスが見つかりませんでした"),
        alignment: Alignment.center,
      ));
    } else {
      widgetHolderState.startNewWidget(ItemListWidget(aBox, widgetHolderState));
    }
    isQrScan = false;
  }
}
