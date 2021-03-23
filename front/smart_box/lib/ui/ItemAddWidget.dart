import "dart:io";

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_box/Base64Utility/Base64Utility.dart';
import 'package:smart_box/Camera/Camera.dart';
import 'package:smart_box/baggage/Item.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/barcode_reader/BarcodeReader.dart';
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/WidgetHolder.dart';

class ItemAddWidget extends StatefulWidget {
  final WidgetHolderState widgetHolderState;
  final Box aBox;
  ItemAddWidget(this.aBox, this.widgetHolderState);
  @override
  _ItemAddWidgetState createState() => _ItemAddWidgetState();
}

class _ItemAddWidgetState extends State<ItemAddWidget> {
  final formKey = GlobalKey<FormState>();
  String _itemName = "";
  String _description = "";
  String _base64Image;

  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text("新しくアイテムを作成"),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: widget.widgetHolderState.onWillPopHandler,
              ),
            ),
            body: Column(children: [
              ///
              /// ボックス名
              ///
              Container(
                  padding: EdgeInsets.fromLTRB(20, 7, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.aBox.boxName,
                    style: TextStyle(fontSize: 16),
                  )),

              ///
              /// フォーム
              ///
              Flexible(
                  child: Form(
                      key: this.formKey,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(30, 5, 30, 10),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Column(children: [
                                ///
                                /// 写真をとる
                                ///
                                GestureDetector(
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
                                    "アイテムの名前",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),

                                ///
                                ///名前
                                ///
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  color: Colors.white,
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: TextFormField(
                                        maxLines: 1,
                                        controller: this._itemNameController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "名前を入力してください";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withAlpha(0))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withAlpha(0))),
                                          hintText: "入力してください",
                                        ),
                                        onSaved: (value) {
                                          this._itemName = value;
                                        },
                                      )),
                                ),

                                ///
                                /// JANコードから追加
                                ///
                                GestureDetector(
                                    onTap: () async {
                                      String result =
                                          await scanBarcode(ScanMode.BARCODE);
                                      if (!mounted) {
                                        return;
                                      }
                                      setState(() {
                                        this._itemNameController =
                                            TextEditingController(text: result);
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "JANコードから追加",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 238, 152, 157)),
                                      ),
                                    )),

                                ///
                                /// メモ
                                ///
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
                                        maxLines: 4,
                                        controller: this._descriptionController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withAlpha(0))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withAlpha(0))),
                                          hintText: "入力してください",
                                        ),
                                        onSaved: (value) {
                                          this._description = value;
                                        },
                                      )),
                                ),
                              ]),

                              ///
                              /// 作成ボタン
                              ///
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
                                      primary:
                                          Color.fromARGB(255, 238, 152, 157),
                                      onPrimary: Colors.white,
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: () async {
                                      ///
                                      ///保存処理
                                      ///
                                      if (this
                                          .formKey
                                          .currentState
                                          .validate()) {
                                        this.formKey.currentState.save();
                                        print(this._itemName);
                                        print(this._description);
                                        print(await createItem(
                                          widget.aBox.id,
                                          Item(1, this._itemName,
                                              description: this._description,
                                              base64Image: this._base64Image),
                                        ));
                                        widget.widgetHolderState
                                            .onWillPopHandler();
                                      }
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
                                      onPrimary:
                                          Color.fromARGB(255, 238, 152, 157),
                                      shape: const StadiumBorder(
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 238, 152, 157))),
                                    ),
                                    onPressed: () {
                                      widget.widgetHolderState
                                          .onWillPopHandler();
                                    },
                                  ))
                            ],
                          )))))
            ])),
        onWillPop: widget.widgetHolderState.onWillPopHandler);
  }

  @override
  void dispose() {
    super.dispose();
    this._itemNameController.dispose();
    this._descriptionController.dispose();
  }
}
