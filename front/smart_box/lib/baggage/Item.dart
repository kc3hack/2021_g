import 'package:flutter/material.dart';
import "package:smart_box/Base64Utility/Base64Utility.dart";

///
/// 一つのアイテムを管理するクラス
///
class Item {
  int _id; //アイテムのid
  String _itemName = ""; // アイテムの名前
  String _description = ""; //アイテムの詳細
  String _base64Image = ""; //base64で表現された画像
  DateTime _createdAt; //作成された時刻
  DateTime _updatedAt; //更新された時刻

  Item(this._id, this._itemName,
      {String description = "",
      String base64Image = "",
      DateTime createdAt,
      DateTime updatedAt})
      : this._description = description,
        this._base64Image = base64Image,
        this._createdAt = createdAt == null ? DateTime.now() : createdAt,
        this._updatedAt = updatedAt == null ? DateTime.now() : updatedAt;

  int get id => this._id;

  String get itemName => this._itemName;

  String get description => this._description;

  String get imagePath => this._base64Image;
  DateTime get createdAt => this._createdAt;
  DateTime get updatedAt => this._updatedAt;

  set itemName(String aString) {
    this._itemName = aString;
  }

  set description(String aString) {
    this._description = aString;
  }

  set base64Image(String aString) {
    this._base64Image = aString;
  }

  set updatedAt(DateTime updatedAt) => this._updatedAt = updatedAt;

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
