import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_box/baggage/Item.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/ItemWidget.dart';

///
/// アイテム一覧を表示するWidget
///
class ItemListWidget extends StatefulWidget {
  final Box aBox; //ボックス
  ItemListWidget(this.aBox);
  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  Box aBox;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    this.aBox = widget.aBox;
    getItems(this.aBox.id, "token").then((items) {
      setState(() {
        this.items = items;
      });
    });
  }

  ///
  /// 最初のボックスの詳細のWidget
  ///
  Widget _makeBoxDescription() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: Text(
              aBox.boxName,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: Text(
              aBox.description,
              style: TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 最後に空の要素を加えることでボタンが押しやすいように
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () => print("pushed"),
            backgroundColor: Color.fromARGB(255, 238, 152, 157),
          ),
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: StaggeredGridView.extentBuilder(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              maxCrossAxisExtent: 200,
              itemCount: this.items.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) return this._makeBoxDescription();
                if (index == this.items.length + 1) return Container();
                return ItemWidget(this.items[index - 1]);
              },
              staggeredTileBuilder: (int index) => StaggeredTile.extent(
                  (index == 0) ? 100 : 1, (index == 0) ? 150 : 170),
            )));
  }
}
