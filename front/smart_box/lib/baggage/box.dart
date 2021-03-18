import "package:smart_box/baggage/Item.dart";

///
/// １つのボックスを管理するクラス
///
class Box {
  String _boxName; //ボックスの名前
  List<Item> _items; //アイテムのリスト

  Box(this._boxName, {List<Item> items = const []}) : this._items = items;

  String get boxName => this._boxName;
  List<Item> get items => this._items;

  ///
  /// ボックスにアイテムを追加する
  ///
  void addItem(Item item) {
    this._items.add(item);
  }
}
