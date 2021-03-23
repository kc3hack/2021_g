import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/server_interface/ServerInterface.dart';

///
/// 文字列に関するユーティリティ
///

///
/// 文字列[qrString]がQRコードから読み取った文字列かどうか判定する
///
bool validateQrString(String qrString) {
  return new RegExp('http://smart_box.com/box/[0-9]+').hasMatch(qrString);
}

///
/// Qrコードの文字列からBoxを取得する
///
/// ないならnull
Future<Box> getBoxFromQrLink(String qrString) async {
  Box resultBox;
  try {
    List<String> stringList = qrString.split("/");
    int boxId = int.parse(stringList.last);
    List<Box> boxes = await getBoxes();
    for (Box box in boxes) {
      if (boxId == box.id) {
        resultBox = box;
      }
    }
  } catch (exception) {
    print(exception);
  }
  return resultBox;
}

///
/// 16進数カラーコードからColorを表す整数へ変換する
///
int getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }
  return int.parse(hexColor, radix: 16);
}
