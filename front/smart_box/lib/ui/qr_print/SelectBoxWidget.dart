import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/qr_print/QrWidgetHolder.dart';
import 'package:smart_box/ui/qr_print/SelectQrWidget.dart';

class SelectBoxWidget extends StatefulWidget {
  final QrWidgetHolderState widgetHolderState;
  SelectBoxWidget(this.widgetHolderState);
  @override
  _SelectBoxWidgetState createState() => _SelectBoxWidgetState();
}

class _SelectBoxWidgetState extends State<SelectBoxWidget> {
  List<Box> boxList = [];
  int selected = -1;

  ///
  /// 表示するボックスを更新する
  ///
  Future<void> _updateBoxList() async {
    this.boxList.clear();
    this.boxList = await getBoxes(widget.widgetHolderState.getIdToken());
    return;
  }

  void _boxTapHandler(int index, Box box) {
    setState(() {
      this.selected = index;
    });
  }

  ///
  /// 一覧に表示する1つのボックスを表すWidgetを作成する
  ///
  Container _makeBoxTile(int index, Box box) {
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
          leading: (this.selected == index)
              ? Icon(Icons.check_box_rounded)
              : Icon(Icons.check_box_outline_blank),
          onTap: () {
            _boxTapHandler(index, box);
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateBoxList().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("QRコードプリント(1/3)"),
          ),
          floatingActionButton: Container(
            width: 90,
            height: 50,
            child: Container(
              //padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (this.selected != -1)
                    ? Color.fromARGB(255, 238, 152, 157)
                    : Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                child: Text(
                  "次へ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (this.selected == -1) {
                    return;
                  }
                  widget.widgetHolderState.add(SelectQrWidget(
                      widget.widgetHolderState, this.boxList[this.selected]));
                },
              ),
            ),
          ),
          body: Column(
            children: [
              ///
              /// 説明欄
              ///
              Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                  child: Row(
                    children: [
                      ///
                      /// stepアイコン
                      ///
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 203, 206),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "step1",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text("ボックスを選択してください",
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      )
                    ],
                  )),

              ///
              ///ボックスのリスト
              ///
              Flexible(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == this.boxList.length)
                      return Container(
                        height: 90,
                      );
                    return this._makeBoxTile(index, this.boxList[index]);
                  },
                  itemCount: this.boxList.length + 1,
                ),
              ),
            ],
          ),
        ),
        onWillPop: widget.widgetHolderState.onWillPopHandler);
  }
}
