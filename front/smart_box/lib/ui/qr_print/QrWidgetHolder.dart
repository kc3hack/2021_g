import 'dart:collection';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_box/ui/qr_print/SelectBoxWidget.dart';

class QrWidgetHolder extends StatefulWidget {
  CognitoUserSession cognitoUserSession;
  QrWidgetHolder(this.cognitoUserSession);
  @override
  QrWidgetHolderState createState() => QrWidgetHolderState();
}

class QrWidgetHolderState extends State<QrWidgetHolder> {
  Queue<Object> routeStack = Queue();
  CognitoUserSession cognitoUserSession;

  String getIdToken() {
    //return "token";
    print("--------------------------------------------------");
    print(widget.cognitoUserSession.getIdToken().getJwtToken());
    return widget.cognitoUserSession.getIdToken().getJwtToken();
  }

  void add(Object aWidget) {
    setState(() {
      this.routeStack.addLast(aWidget);
    });
  }

  void pop() {
    if (this.routeStack.length != 0) {
      setState(() {
        this.routeStack.removeLast();
      });
    }
  }

  Object now() {
    if (this.routeStack.length == 0) {
      return null;
    }
    return this.routeStack.last;
  }

  ///
  /// 戻るボタンが押された時の処理
  ///
  Future<bool> onWillPopHandler() async {
    setState(() {
      print(this.now());
      this.pop();
    });
    return false;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.routeStack.add(SelectBoxWidget(this));
    });
  }

  @override
  Widget build(BuildContext context) {
    return (this.now() == null) ? Container() : this.now();
  }
}
