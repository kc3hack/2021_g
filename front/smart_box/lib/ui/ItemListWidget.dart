import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_box/baggage/Item.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/ItemAddWidget.dart';
import 'package:smart_box/ui/ItemWidget.dart';
import 'package:smart_box/ui/BoxWidgetHolder.dart';

///
/// アイテム一覧を表示するWidget
///
class ItemListWidget extends StatefulWidget {
  final Box aBox; //ボックス
  final BoxWidgetHolderState widgetHolderState;
  ItemListWidget(this.aBox, this.widgetHolderState);
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
      if (!mounted) {
        return;
      }
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

  Widget _makeScaffold() {
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
            onPressed: () => widget.widgetHolderState
                .add(ItemAddWidget(this.aBox, widget.widgetHolderState)),
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

  ///
  /// 最後に空の要素を加えることでボタンが押しやすいように
  ///
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("アイテム一覧"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: widget.widgetHolderState.onWillPopHandler,
              color: Theme.of(context).accentColor,
            ),
            actions: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 40,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      print("search button pushed");
                    },
                  ))
            ],
          ),
          body: this._makeScaffold(),
        ),
        onWillPop: widget.widgetHolderState.onWillPopHandler);
  }
}
