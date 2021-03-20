import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/BoxAddWidget.dart';
import 'package:smart_box/ui/BoxWidgetHolder.dart';
import 'package:smart_box/ui/ItemListWidget.dart';

///
/// ボックス一覧画面のWidget
///
/// アイテム表示一覧とbodyを入れ替えている
/// これによりbottomNavigationを表示したまま遷移している
///
class BoxListWidget extends StatefulWidget {
  final BoxWidgetHolderState widgetHolderState;
  BoxListWidget(this.widgetHolderState);
  @override
  _BoxListWidgetState createState() => _BoxListWidgetState();
}

class _BoxListWidgetState extends State<BoxListWidget> {
  List<Box> boxList = [];

  ///
  /// 表示するボックスを更新する
  ///
  Future<void> _updateBoxList() async {
    this.boxList.clear();
    this.boxList = await getBoxes(widget.widgetHolderState.getIdToken());
    return;
  }

  ///
  /// リストのボックスをタップした時の処理
  ///
  void _boxTapHandler(Box box) {
    widget.widgetHolderState.add(ItemListWidget(box, widget.widgetHolderState));
  }

  Future<void> _boxLong(int index, Box box) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(box.boxName + "を削除しますか？"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("キャンセル"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: Text("削除"),
              isDestructiveAction: true,
              onPressed: () async {
                Navigator.pop(context);
                deleteBox(box.id, widget.widgetHolderState.getIdToken())
                    .then((value) {
                  if (value) {
                    setState(() {
                      this.boxList.removeAt(index);
                    });
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

  ///
  /// 一覧に表示する1つのボックスを表すWidgetを作成する
  ///
  Container _makeBoxTile(int index, Box box) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ListTile(
          title: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                box.boxName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              )),
          leading: Container(
            width: size.width / 5,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: (box.getImage() == null)
                ? Image.asset(
                    "images/dummy.png",
                    fit: BoxFit.cover,
                  )
                : box.getImage(),
          ),
          subtitle: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                box.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, height: 1.2),
              )),
          onTap: () {
            this._boxTapHandler(box);
          },
          onLongPress: () async {
            await this._boxLong(index, box);
          },
        ));
  }

  ///
  /// ボックスのリストを表示するWidget
  ///
  /// 最後に空の要素を加えることでボタンが押しやすいように
  ///
  Scaffold _makeBoxList() {
    List<Widget> aList = [];
    for (int i = 0; i < this.boxList.length; i++) {
      aList.add(_makeBoxTile(i, this.boxList[i]));
    }
    //空の要素を追加
    aList.add(Container(
      height: 100,
    ));
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
            onPressed: () => widget.widgetHolderState
                .add(BoxAddWidget(widget.widgetHolderState)),
            backgroundColor: Color.fromARGB(255, 238, 152, 157),
          ),
        ),
        body: Container(
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
        ])));
  }

  @override
  void initState() {
    super.initState();
    _updateBoxList().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return this._makeBoxList();
  }
}
