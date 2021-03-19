import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_box/baggage/Item.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/json_utility/JsonUtility.dart';

final String baseUrl =
    "https://1f2e643e-b69a-43b3-8731-606a8eedde30.mock.pstmn.io/";

enum ClientRequest { POST, PUT, GET, DELETE }

///
/// サーバへのリクエスト
///
Future<String> _request(String url, ClientRequest request, String token,
    {String body = ""}) async {
  Map<String, String> headers = {
    'content-type': 'application/json',
    "Authorization": token,
  };
  url = baseUrl + url;
  http.Response resp;
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
      resp = await http.put(url, headers: headers);
      break;
  }
  if (resp.statusCode >= 300) {
    print(resp.statusCode);
    print(resp.body);
    throw Exception("status code: " + resp.statusCode.toString());
  }
  return resp.body;
}

///
/// サーバからボックスのリストを取得する
///
Future<List<Box>> getBoxes(String token) async {
  String jsonString = await _request("/boxes", ClientRequest.GET, token);
  return jsonToBoxes(jsonString);
}

///
/// サーバにボックスを追加する
///
Future<Box> createBox(Box aBox, String token) async {
  String body = json.encode({
    "name": aBox.boxName,
    "icon": aBox.base64Image,
    "note": aBox.description
  });
  String jsonString =
      await _request("boxes", ClientRequest.POST, token, body: body);
  return jsonToBox(jsonString);
}

///
/// サーバのボックスを編集する
///
Future<Box> updateBox(int boxId, Box aBox, String token) async {
  String body = json.encode({
    "name": aBox.boxName,
    "icon": aBox.base64Image,
    "note": aBox.description
  });
  String jsonString = await _request(
      "boxes/" + boxId.toString(), ClientRequest.POST, token,
      body: body);
  return jsonToBox(jsonString);
}

///
/// サーバからボックスを削除する
///
Future<bool> deleteBox(int boxId, String token) async {
  await _request("boxes/" + boxId.toString(), ClientRequest.DELETE, token);
  return true;
}

///
/// ボックスからQRコードを表すBASE64文字列を取得
///
Future<String> getQr(int boxId, String token) async {
  String base64String = await _request(
      "boxes/" + boxId.toString() + "/qr", ClientRequest.GET, token);
  return base64String;
}

///
/// サーバからアイテム一覧を取得する
///
Future<List<Item>> getItems(int boxId, String token) async {
  String jsonString = await _request(
      "boxes/" + boxId.toString() + "/items", ClientRequest.GET, token);
  return jsonToItems(jsonString);
}

///
/// サーバにボックスを追加する
///
Future<Item> createItem(int boxId, Item item, String token) async {
  String body = json.encode({
    "name": item.itemName,
    "icon": item.base64Image,
    "note": item.description
  });
  String jsonString = await _request(
      "boxes/" + boxId.toString() + "/items", ClientRequest.POST, token,
      body: body);
  return jsonToItem(jsonString);
}

///
/// サーバのボックスにアイテムを追加する
///
Future<Item> updateItem(int itemId, Item item, String token) async {
  String body = json.encode({
    "name": item.itemName,
    "icon": item.base64Image,
    "note": item.description
  });
  String jsonString = await _request(
      "items/" + itemId.toString(), ClientRequest.PUT, token,
      body: body);
  return jsonToItem(jsonString);
}

///
/// サーバのボックスからアイテムを削除する
///
Future<bool> deleteItem(int itemId, String token) async {
  await _request("items/" + itemId.toString(), ClientRequest.DELETE, token);
  return true;
}
