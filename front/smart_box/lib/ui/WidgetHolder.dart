import 'dart:collection';

import 'package:flutter/cupertino.dart';

///
/// ウィジェットの遷移を管理するクラス
///
class WidgetHolderState<T extends StatefulWidget> extends State<T> {
  Queue<Object> routeStack = Queue();

  ///
  /// 新しいウィジェットに遷移する
  ///
  void add(Object aWidget) {
    setState(() {
      this.routeStack.addLast(aWidget);
    });
  }

  ///
  /// ひとつ前のウィジェットに戻る
  ///
  void pop() {
    if (this.routeStack.length != 0) {
      setState(() {
        this.routeStack.removeLast();
      });
    }
  }

  ///
  /// スタックしてるウィジェットを破棄して新たに始める
  ///
  void startNewWidget(Object aWidget) {
    this.routeStack.clear();
    this.add(aWidget);
  }

  ///
  /// 現在表示しているウィジェットを取得
  ///
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
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
