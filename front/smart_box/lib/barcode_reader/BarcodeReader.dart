///
/// QRおよびバーコードを読み込む関数
///
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

/// QR・バーコードをスキャンし文字列として返す
/// [scanMode]に対応したコードを読み込む
/// スキャン中の線の色は[hexString]で、スキャンするか、[cancel]を押すと終了。
/// [isFlushButtonVisible]が正ならフラッシュボタンを表示
///
Future<String> scanBarcode(ScanMode scanMode,
    {String hexString = "#ff6666",
    String cancel = "Cancel",
    bool isFlushButtonVisible = true}) async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        hexString, cancel, isFlushButtonVisible, scanMode);
    print(barcodeScanRes);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  }
  return barcodeScanRes;

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  //if (!mounted) return;
}
