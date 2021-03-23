import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/ui/WidgetHolder.dart';
import 'package:smart_box/ui/qr_print/QrResultWidget.dart';

enum PrintType { BIG, MIDDLE, SMALL, STRIP }

class SelectQrWidget extends StatefulWidget {
  final WidgetHolderState widgetHolderState;
  final Box aBox;
  SelectQrWidget(this.widgetHolderState, this.aBox);
  @override
  _SelectQrWidgetState createState() => _SelectQrWidgetState();
}

class _SelectQrWidgetState extends State<SelectQrWidget> {
  PrintType _type;

  void _handleRadio(PrintType type) => setState(() {
        _type = type;
      });
  Widget makeQrTile(Image image, PrintType type) {
    String size;
    String number;
    final Size monitorSize = MediaQuery.of(context).size;
    switch (type) {
      case PrintType.BIG:
        size = "大サイズ";
        number = "QRコード×4";
        break;
      case PrintType.MIDDLE:
        size = "中サイズ";
        number = "QRコード×6";
        break;
      case PrintType.SMALL:
        size = "小サイズ";
        number = "QRコード×8";
        break;
      case PrintType.STRIP:
        size = "短冊サイズ";
        number = "短冊型×4     ";
        break;
    }
    return GestureDetector(
        onTap: () {
          _handleRadio(type);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            new Radio(
              activeColor: Colors.grey,
              value: type,
              groupValue: _type,
              onChanged: _handleRadio,
            ),
            Container(
              width: monitorSize.width / 3,
              height: (monitorSize.height + monitorSize.width) / 10,
              child: image,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(size), Text(number)],
                ))
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text("QRコードプリント(2/3)"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: widget.widgetHolderState.onWillPopHandler,
                color: Theme.of(context).accentColor,
              ),
            ),
            floatingActionButton: Container(
              width: 90,
              height: 50,
              child: Container(
                //padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (this._type != null)
                      ? Color.fromARGB(255, 238, 152, 157)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  child: Text(
                    "保存",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (this._type == null) {
                      return;
                    }
                    widget.widgetHolderState.add(QrResultWidget(
                        widget.widgetHolderState, widget.aBox, _type));
                  },
                ),
              ),
            ),
            body: Column(children: [
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
                          "step2",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text("QRコードを選択し保存してください",
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      )
                    ],
                  )),
              Flexible(
                  child: ListView(
                children: [
                  this.makeQrTile(Image.asset("images/L.png"), PrintType.BIG),
                  this.makeQrTile(
                      Image.asset("images/M.png"), PrintType.MIDDLE),
                  this.makeQrTile(Image.asset("images/S.png"), PrintType.SMALL),
                  this.makeQrTile(
                      Image.asset("images/Strip.png"), PrintType.STRIP),
                  Container(
                    height: 100,
                  ),
                ],
              ))
            ])),
        onWillPop: widget.widgetHolderState.onWillPopHandler);
  }
}
