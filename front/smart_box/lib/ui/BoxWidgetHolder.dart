import 'dart:collection';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_box/ui/BoxListWidget.dart';

class BoxWidgetHolder extends StatefulWidget {
  @override
  BoxWidgetHolderState createState() => BoxWidgetHolderState();
}

class BoxWidgetHolderState extends State<BoxWidgetHolder> {
  Queue<Object> routeStack = Queue();
  CognitoUserSession cognitoUserSession;

  String getIdToken() {
    return "token";
    //return cognitoUserSession.getIdToken().getJwtToken();
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
      this.routeStack.add(BoxListWidget(this));
    });
  }

  @override
  Widget build(BuildContext context) {
    return (this.now() == null) ? Container() : this.now();
  }
}
