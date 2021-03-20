import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                              onTap: () async {},
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                height: 200,
                                child: Image.asset("images/addPhoto.png"),
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "入力してください",
                              ),
                              onSaved: (value) {
                                this._boxName = value;
                              },
                            ),
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
                            child: TextFormField(
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "入力してください",
                              ),
                              onSaved: (value) {
                                this._description = value;
                              },
                            ),
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
                              onPressed: () {
                                ///
                                ///保存処理
                                ///
                                this.formKey.currentState.save();
                                print(this._boxName);
                                print(this._description);
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
