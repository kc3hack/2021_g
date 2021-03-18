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

  @override
  Widget build(BuildContext context) {
    Widget image = this.anItem.getImage();
    if (image == null) image = Container();

    return Container(
        color: Colors.white,
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
}
