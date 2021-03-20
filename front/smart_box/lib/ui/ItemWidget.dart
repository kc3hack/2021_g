import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:smart_box/baggage/Item.dart";

///
/// アイテム一覧に表示される1つのアイテムを表すWidget
///
class ItemWidget extends StatelessWidget {
  final Item anItem; //　表示するアイテム
  ItemWidget(this.anItem);

  ///
  /// アイテムがタップされた時の処理
  ///
  void touchEvent() {
    print(this.anItem.itemName);
  }

  Widget _makeItemWidget() {
    Widget image = this.anItem.getImage();
    if (image == null) image = Image.asset("images/dummy.png");
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.black12, width: 2),
            )),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: GestureDetector(
            onTap: touchEvent,
            child: Column(
              children: <Widget>[
                Flexible(
                    child: Container(
                  child: image,
                )),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      this.anItem.itemName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return this._makeItemWidget();
  }
}
