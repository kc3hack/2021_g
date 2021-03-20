import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:smart_box/ui/BoxListWidget.dart';

class WidgetHolder extends StatefulWidget {
  @override
  WidgetHolderState createState() => WidgetHolderState();
}

class WidgetHolderState extends State<WidgetHolder> {
  Queue<Object> routeStack = Queue();

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
