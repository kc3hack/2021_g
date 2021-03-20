import 'dart:convert';

import 'package:smart_box/baggage/Item.dart';
import 'package:smart_box/baggage/box.dart';

Item _mapToItem(Map<String, dynamic> itemMap) {
  int id = itemMap["id"];
  String name = itemMap["name"];
  String description = itemMap["note"];
  String icon = itemMap["icon"];
  DateTime createdAt = DateTime.parse(itemMap["created_at"]);
  DateTime updatedAt = DateTime.parse(itemMap["updated_at"]);
  return Item(id, name,
      description: description,
      base64Image: icon,
      createdAt: createdAt,
      updatedAt: updatedAt);
}

Box _mapToBox(Map<String, dynamic> boxMap) {
  int id = boxMap["id"];
  String name = boxMap["name"];
  String description = boxMap["note"];
  String icon = boxMap["icon"];
  DateTime createdAt = DateTime.parse(boxMap["created_at"]);
  DateTime updatedAt = DateTime.parse(boxMap["updated_at"]);
  return Box(id, name,
      description: description,
      base64Image: icon,
      createdAt: createdAt,
      updatedAt: updatedAt);
}

Item jsonToItem(String jsonString) {
  Map<String, dynamic> itemMap = json.decode(jsonString);
  return _mapToItem(itemMap);
}

List<Item> jsonToItems(String jsonString) {
  List<dynamic> jsonItems = json.decode(jsonString);
  List<Item> items = jsonItems.map((itemMap) => (_mapToItem(itemMap))).toList();
  return items;
}

Box jsonToBox(String jsonString) {
  Map<String, dynamic> boxMap = json.decode(jsonString);
  return _mapToBox(boxMap);
}

List<Box> jsonToBoxes(String jsonString) {
  List<dynamic> jsonBoxes = json.decode(jsonString);
  List<Box> boxes = jsonBoxes.map((boxMap) => (_mapToBox(boxMap))).toList();
  return boxes;
}
