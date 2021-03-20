import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/qr_print/QrWidgetHolder.dart';

class SelectBoxWidget extends StatefulWidget {
  final QrWidgetHolderState widgetHolderState;
  SelectBoxWidget(this.widgetHolderState);
  @override
  _SelectBoxWidgetState createState() => _SelectBoxWidgetState();
}

class _SelectBoxWidgetState extends State<SelectBoxWidget> {
  List<Box> boxList = [];

  ///
  /// 表示するボックスを更新する
  ///
  Future<void> _updateBoxList() async {
    this.boxList.clear();
    this.boxList = await getBoxes(widget.widgetHolderState.getIdToken());
    return;
  }

  void _boxTapHandler(Box box) {}

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
            _boxTapHandler(box);
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
                              fontSize: 16,
                            )),
                      )
                    ],
                  )),

              ///
              ///ボックスのリスト
              ///
              Flexible(
                  child: ListView(
                children: (this.boxList.isEmpty)
                    ? [Container()]
                    : this.boxList.map((box) => _makeBoxTile(box)).toList(),
              )),
            ],
          ),
        ),
        onWillPop: widget.widgetHolderState.onWillPopHandler);
  }
}
