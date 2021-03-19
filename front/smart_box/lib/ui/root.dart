import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/ui/BoxListWidget.dart';

import 'BottomNavBar.dart';
import 'Camera.dart';

class RootWidget extends StatefulWidget {
  RootWidget({Key key}) : super(key: key);

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  static int selectedIndex = 0;

  var _routes = [
    BoxListWidget(),
    Camera(),
    Camera(),
  ];

  // まだ使っていない _selectedIndexを共有する
  setBottomBarIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _routes.elementAt(selectedIndex),
      // bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex,setBottomBarIndex: setBottomBarIndex,),
      body: Column(children: [
        Expanded(flex: 6, child: _routes.elementAt(selectedIndex)),
        Expanded(
            flex: 1,
            child: BottomNavBar(
              selectedIndex: selectedIndex,
              setBottomBarIndex: setBottomBarIndex,
            )),
      ]),
    );
  }
}
