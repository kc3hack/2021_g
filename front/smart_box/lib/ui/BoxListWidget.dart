import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/baggage/Item.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/ui/ItemListWidget.dart';

///
/// ボックス一覧画面のWidget
///
/// アイテム表示一覧とbodyを入れ替えている
/// これによりbottomNavigationを表示したまま遷移している
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
        itemList.add(Item(i * 10 + j, boxName + "アイテム" + j.toString(),
            base64Image:
                "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"));
      }
      this.boxList.add(Box(i, boxName, items: itemList));
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
