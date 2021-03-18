import 'dart:io';

import 'package:flutter/material.dart';

///
/// 一つのアイテムを管理するクラス
///
class Item {
  String _itemName = ""; // アイテムの名前
  String _description = ""; //アイテムの詳細
  String _imagePath = ""; //画像のパス

  Item(this._itemName, {String description = "", String imagePath = ""})
      : this._description = description,
        this._imagePath = imagePath;

  String get itemName => this._itemName;
  String get description => this._description;
  String get imagePath => this._imagePath;

  ///
  /// imagePathからImage型を返す
  ///
  /// imagePathがURLならネットワークを通して、ディレクトリへのパスならそこから取得する。
  /// imagePathに画像が存在しないならnullを返す
  ///
  Image getImage() {
    Image aImage;
    print(this._imagePath);
    try {
      if (RegExp('^(http|https)').hasMatch(this._imagePath)) {
        aImage = Image.network(this._imagePath);
      } else {
        aImage = Image.file(File(this._imagePath));
      }
    } catch (anException) {
      print(anException);
      return null;
    }
    return aImage;
  }
}
