import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/ui/qr_print/QrWidgetHolder.dart';
import 'package:smart_box/ui/qr_print/SelectQrWidget.dart';
import "package:url_launcher/url_launcher.dart";

class QrResultWidget extends StatefulWidget {
  final QrWidgetHolderState widgetHolderState;
  final PrintType type;
  final Box aBox;
  QrResultWidget(this.widgetHolderState, this.aBox, this.type);
  @override
  _QrResultWidgetState createState() => _QrResultWidgetState();
}

class _QrResultWidgetState extends State<QrResultWidget> {
  ///
  /// ストレージの許可を要請する
  ///
  Future<void> showRequestDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('QRコードを保存するためにはストレージの許可が必要です'),
            content: Text("QRコードを保存するために使用します"),
            actions: <Widget>[
              TextButton(
                child: Text("キャンセル"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("設定"),
                onPressed: () async {
                  openAppSettings();
                },
              ),
            ],
          );
        });
  }

  ///
  /// QRコードを作成する
  ///
  Future<void> createQr() async {
    if (await Permission.storage.isPermanentlyDenied) {
      await showRequestDialog();
    }
    if (await Permission.storage.isUndetermined) {
      await showRequestDialog();
    }

    if (await Permission.storage.isGranted) {
      // String base64String =
      //     await getQr(widget.aBox.id, widget.widgetHolderState.getIdToken());
      // print(ImageGallerySaver.saveImage(base64ToUnit8List(base64String)));
    }
  }

  ///
  /// 一覧に表示する1つのボックスを表すWidgetを作成する
  ///
  Container _makeBoxTile(Image image, String text) {
    final Size monitorSize = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.fromLTRB(25, 15, 10, 5),
        child: Row(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            width: monitorSize.width / 3,
            height: (monitorSize.height + monitorSize.width) / 9.8,
            child: image,
          ),
          Flexible(
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 14),
                  )))
        ]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createQr();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text("QRコードプリント(3/3)"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: widget.widgetHolderState.onWillPopHandler,
                color: Theme.of(context).accentColor,
              ),
            ),
            body: Column(children: [
              ///
              /// 説明欄
              ///
              Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
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
                          "step3",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text("印刷してボックスに貼り付けよう",
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      )
                    ],
                  )),
              Flexible(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  this._makeBoxTile(Image.asset("images/qr-first.png"),
                      "保存した画像は、LINEの公式アカウントに送って、印刷しよう！"),
                  this._makeBoxTile(Image.asset("images/qr-second.png"),
                      "印刷したQRコードは、段ボールやファイルの側面に貼り付けよう！"),
                  this._makeBoxTile(Image.asset("images/qr-third.png"),
                      "これでいつでも、箱をあけずとも、中身を見ることができるよ！"),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Container(
                            child: Text("公式LINEアカウントはこちら！"),
                            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                          )),
                          GestureDetector(
                              onTap: () async {
                                await canLaunch(
                                        "https://social-plugins.line.me/lineit/share?url=https%3A%2F%2Fline.me%2Fen")
                                    ? await launch(
                                        "https://social-plugins.line.me/lineit/share?url=https%3A%2F%2Fline.me%2Fen")
                                    : print("Can not launch");
                              },
                              child: Container(
                                width: 140,
                                height: 50,
                                child: Image.asset("images/line.png"),
                              ))
                        ],
                      ))
                ],
              )))
            ])),
        onWillPop: widget.widgetHolderState.onWillPopHandler);
  }
}
