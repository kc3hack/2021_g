import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/baggage/Item.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/ui/ItemListWidget.dart';

///
/// ボックス一覧画面のWidget
///
class BoxListWidget extends StatefulWidget {
  @override
  _BoxListWidgetState createState() => _BoxListWidgetState();
}

class _BoxListWidgetState extends State<BoxListWidget> {
  List<Box> boxList = [];
  bool _isBoxSelected = false;
  Box _selectedBox;

  ///
  /// 表示するボックスを更新する
  ///
  Future<void> _updateBoxList() async {
    this.boxList.clear();
    for (int i = 0; i < 5; i++) {
      String boxName = "テストボックス" + i.toString();
      List<Item> itemList = [];
      for (int j = 0; j < 10; j++) {
        itemList.add(Item(boxName + "アイテム" + j.toString(),
            imagePath:
                "https://kaiunillust.com/wp-content/uploads/2018/12/usagi-hude.jpg"));
      }
      this.boxList.add(Box(boxName, items: itemList));
    }
    return;
  }

  ///
  /// リストのボックスをタップした時の処理
  ///
  void _boxTapHandler(Box box) {
    setState(() {
      this._isBoxSelected = true;
      this._selectedBox = box;
    });
  }

  ///
  /// アイテム一覧で戻るボタンが押された時の処理
  ///
  Future<bool> _onWillPopHandler() async {
    setState(() {
      this._isBoxSelected = false;
    });
    return false;
  }

  ///
  /// アイテム一覧を表示するためのWidgetを作成する
  ///
  WillPopScope _makeItemList() {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("アイテム一覧"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: _onWillPopHandler,
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
          body: ItemListWidget(this._selectedBox),
        ),
        onWillPop: this._onWillPopHandler);
  }

  ///
  /// 一覧に表示する1つのボックスを表すWidgetを作成する
  ///
  Container _makeBoxTile(Box box) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ListTile(
          title: Text(
            box.boxName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ),
          leading: Icon(Icons.check_box_outline_blank),
          onTap: () {
            this._boxTapHandler(box);
          },
        ));
  }

  ///
  /// ボックスのリストを表示するWidget
  ///
  Scaffold _makeBoxList() {
    return Scaffold(
        appBar: AppBar(
          title: Text("ホーム"),
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
        body: FutureBuilder(
            future: _updateBoxList(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              List<Widget> aList =
                  this.boxList.map((box) => _makeBoxTile(box)).toList();
              return Container(
                  child: Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Text(
                    "すべてのボックス",
                    style: TextStyle(fontSize: 16),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Flexible(
                    child: ListView(
                  children: aList,
                ))
              ]));
            }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (this._isBoxSelected) ? this._makeItemList() : this._makeBoxList();
  }
}
