import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/baggage/box.dart';
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

  @override
  void initState() {
    super.initState();
    this.aBox = widget.aBox;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemWidgetList =
        this.aBox.items.map((item) => ItemWidget(item)).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("アイテム一覧"),
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
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        this.aBox.boxName,
                        style: TextStyle(fontSize: 16),
                      )),
                  Flexible(
                      child: GridView.extent(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    maxCrossAxisExtent: 200,
                    children: itemWidgetList,
                  ))
                ])));
  }
}
