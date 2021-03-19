import 'package:flutter/material.dart';
import 'package:smart_box/Base64Utility/Base64Utility.dart';
import "package:smart_box/baggage/Item.dart";

///
/// １つのボックスを管理するクラス
///
class Box {
  int _id; //アイテムのid
  String _boxName; //ボックスの名前
  String _base64Image; //ボックスの画像
  List<Item> _items; //アイテムのリスト

  Box(this._id, this._boxName, {List<Item> items = const []})
      : this._items = items;

  int get id => this._id;
  String get boxName => this._boxName;
  String get base64Image => this._base64Image;
  List<Item> get items => this._items;

  set boxName(String name) => this._boxName = name;
  set base64Image(String base64String) => this._base64Image = base64String;
  set items(List<Item> items) => this._items = items;

  ///
  /// インデックス番号からアイテムを取得する
  ///
  /// 存在しないインデックスを指定した場合はnull
  ///
  Item getItemByIndex(int index) {
    if (index < 0 || this._items.length <= index) {
      return null;
    }
    return items[index];
  }

  ///
  /// idからアイテムを取得する
  ///
  /// 存在しないidを指定した場合はnull
  ///
  Item getItemById(int id) {
    for (Item item in this._items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  ///
  /// アイテム名からアイテムを取得
  ///
  /// 存在しない場合はnull
  ///
  Item getItemByName(String itemName) {
    for (Item item in this._items) {
      if (item.itemName == itemName) {
        return item;
      }
    }
    return null;
  }

  ///
  /// ボックスにアイテムを追加する
  ///
  void addItem(Item item) {
    this._items.add(item);
  }

  ///
  /// ボックスにアイテムを複数追加する
  ///
  void addItemAll(Iterable<Item> items) {
    this._items.addAll(items);
  }

  ///
  /// Imageを返す
  ///
  /// 画像が存在しないならnullを返す
  ///
  Image getImage() {
    if (this._base64Image == "") {
      return null;
    }

    return base64ToImage(this._base64Image);
  }

  @override
  bool operator ==(Object other) => other is Item && other.id == id;

  @override
  int get hashCode => this._id;
}
