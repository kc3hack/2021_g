import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smart_box/baggage/Item.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/json_utility/JsonUtility.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

// final String baseUrl =
//     "https://ea950b6b-7863-4af5-b00b-2544f5791757.mock.pstmn.io/";
final String baseUrl = "https://smartbox.yukiho.dev/";

enum ClientRequest { POST, PUT, GET, DELETE }

String getCookies(List<Cookie> cookies) {
  return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
}

///
/// サーバへのリクエスト
///
Future<String> _request(String url, ClientRequest request,
    {String body = ""}) async {
  final cookieManager = WebviewCookieManager();
  final gotCookies =
      await cookieManager.getCookies('https://smartbox.yukiho.dev/');
  final cookie = getCookies(gotCookies);
  print(cookie);

  Map<String, String> headers = {
    'content-type': 'application/json',
    HttpHeaders.cookieHeader: cookie,
  };
  url = baseUrl + url;
  http.Response resp;
  print(url);
  switch (request) {
    case ClientRequest.GET:
      resp = await http.get(url, headers: headers);
      break;
    case ClientRequest.POST:
      resp = await http.post(url, headers: headers, body: body);
      break;
    case ClientRequest.PUT:
      resp = await http.put(url, headers: headers, body: body);
      break;
    case ClientRequest.DELETE:
      resp = await http.delete(url, headers: headers);
      break;
  }
  if (resp.statusCode >= 300) {
    print(resp.statusCode);
    print(resp.body);
    throw Exception("status code: " + resp.statusCode.toString());
  }
  print(resp.body);
  return resp.body;
}

///
/// サーバからボックスのリストを取得する
///
Future<List<Box>> getBoxes() async {
  String jsonString = await _request(
    "boxes",
    ClientRequest.GET,
  );
  print(jsonString);
  return jsonToBoxes(jsonString);
}

///
/// サーバにボックスを追加する
///
Future<Box> createBox(
  Box aBox,
) async {
  String body = json.encode({
    "name": aBox.boxName,
    "icon": aBox.base64Image,
    "note": aBox.description,
  });
  print(body);
  String jsonString = await _request("boxes", ClientRequest.POST, body: body);
  return jsonToBox(jsonString);
}

///
/// サーバのボックスを編集する
///
Future<Box> updateBox(
  int boxId,
  Box aBox,
) async {
  String body = json.encode({
    "name": aBox.boxName,
    "icon": aBox.base64Image,
    "note": aBox.description
  });
  String jsonString = await _request(
      "boxes/" + boxId.toString(), ClientRequest.POST,
      body: body);
  return jsonToBox(jsonString);
}

///
/// サーバからボックスを削除する
///
Future<bool> deleteBox(
  int boxId,
) async {
  await _request(
    "boxes/" + boxId.toString(),
    ClientRequest.DELETE,
  );
  return true;
}

///
/// ボックスからQRコードを表すBASE64文字列を取得
///
Future<String> getQr(
  int boxId,
) async {
  String base64String = await _request(
    "boxes/" + boxId.toString() + "/qr",
    ClientRequest.GET,
  );
  return base64String;
}

///
/// サーバからアイテム一覧を取得する
///
Future<List<Item>> getItems(
  int boxId,
) async {
  String jsonString = await _request(
    "boxes/" + boxId.toString() + "/items",
    ClientRequest.GET,
  );
  return jsonToItems(jsonString);
}

///
/// サーバにボックスを追加する
///
Future<Item> createItem(
  int boxId,
  Item item,
) async {
  String body = json.encode({
    "name": item.itemName,
    "icon": item.base64Image,
    "note": item.description
  });
  String jsonString = await _request(
      "boxes/" + boxId.toString() + "/items", ClientRequest.POST,
      body: body);
  return jsonToItem(jsonString);
}

///
/// サーバのボックスにアイテムを追加する
///
Future<Item> updateItem(
  int itemId,
  Item item,
) async {
  String body = json.encode({
    "name": item.itemName,
    "icon": item.base64Image,
    "note": item.description
  });
  String jsonString = await _request(
      "items/" + itemId.toString(), ClientRequest.PUT,
      body: body);
  return jsonToItem(jsonString);
}

///
/// サーバのボックスからアイテムを削除する
///
Future<bool> deleteItem(
  int itemId,
) async {
  await _request(
    "items/" + itemId.toString(),
    ClientRequest.DELETE,
  );
  return true;
}

///
/// JANコードを読み取る
///
Future<Item> readJan(
  String code,
) async {
  String jsonString = await _request(
    "products?jan=" + code,
    ClientRequest.GET,
  );
  List<String> qrItem = jsonToQrItem(jsonString);
  if (qrItem[0] == null) {
    return null;
  }
  Item item =
      Item(-1, qrItem[0], base64Image: (qrItem[1] == null) ? "" : qrItem[1]);
  return item;
}
