import "dart:io";

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/Base64Utility/Base64Utility.dart';
import 'package:smart_box/Camera/Camera.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/WidgetHolder.dart';

class BoxAddWidget extends StatefulWidget {
  final WidgetHolderState widgetHolderState;
  BoxAddWidget(this.widgetHolderState);
  @override
  _BoxAddWidgetState createState() => _BoxAddWidgetState();
}

class _BoxAddWidgetState extends State<BoxAddWidget> {
  final formKey = GlobalKey<FormState>();
  String _boxName = "";
  String _description = "";
  String _base64Image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text("新しくボックスを作成"),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: widget.widgetHolderState.onWillPopHandler,
              ),
            ),
            body: Form(
                key: this.formKey,
                child: Container(
                    margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Column(children: [
                          GestureDetector(

                              ///
                              /// 写真をとる
                              ///
                              onTap: () async {
                                String imagePath = await takePicture();
                                if (imagePath != "") {
                                  ///画面回転で落ちる
                                  if (!mounted) {
                                    File(imagePath).delete();
                                    return;
                                  }
                                  setState(() {
                                    this._base64Image =
                                        imageToBase64(File(imagePath));
                                    File(imagePath).delete();
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                height: 200,
                                child: (this._base64Image == null)
                                    ? Image.asset("images/addPhoto.png")
                                    : base64ToImage(this._base64Image),
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ボックスの名前",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            color: Colors.white,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextFormField(
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(0))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(0))),
                                    hintText: "入力してください",
                                  ),
                                  onSaved: (value) {
                                    this._boxName = value;
                                  },
                                )),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "メモ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                            color: Colors.white,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextFormField(
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(0))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(0))),
                                    hintText: "入力してください",
                                  ),
                                  onSaved: (value) {
                                    this._description = value;
                                  },
                                )),
                          ),
                        ]),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            width: size.width * 0.5,
                            height: (size.width + size.height) * 0.05,
                            child: ElevatedButton(
                              child: const Text(
                                '作成する',
                                style: TextStyle(),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 238, 152, 157),
                                onPrimary: Colors.white,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () async {
                                ///
                                ///保存処理
                                ///
                                this.formKey.currentState.save();
                                print(this._boxName);
                                print(this._description);
                                await createBox(
                                    Box(1, this._boxName,
                                        description: this._description,
                                        base64Image: this._base64Image),
                                    "token");
                                widget.widgetHolderState.onWillPopHandler();
                              },
                            )),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                            width: size.width * 0.5,
                            height: (size.width + size.height) * 0.05,
                            child: ElevatedButton(
                              child: const Text(
                                'キャンセル',
                                style: TextStyle(),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Color.fromARGB(255, 238, 152, 157),
                                shape: const StadiumBorder(
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 238, 152, 157))),
                              ),
                              onPressed: () {
                                widget.widgetHolderState.onWillPopHandler();
                              },
                            ))
                      ],
                    ))))),
        onWillPop: widget.widgetHolderState.onWillPopHandler);
  }
}
