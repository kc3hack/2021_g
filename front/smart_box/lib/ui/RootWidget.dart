import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/ui/BottomNavBar.dart';
import 'package:smart_box/ui/BoxListWidget.dart';
import 'package:smart_box/ui/QrScan.dart';
import "package:smart_box/ui/WidgetHolder.dart";
import 'package:smart_box/ui/qr_print/SelectBoxWidget.dart';

class RootWidget extends StatefulWidget {
  RootWidget({Key key}) : super(key: key);

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends WidgetHolderState<RootWidget> {
  int selectedIndex = 0;

  void setBottomBarIndex(index) {
    this.selectedIndex = index;
    switch (index) {
      case 0:
        this.startNewWidget(BoxListWidget(this));
        break;
      case 1:
        this.startNewWidget(QrScan(this));
        break;
      case 2:
        super.startNewWidget(SelectBoxWidget(this));
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.startNewWidget(BoxListWidget(this));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _routes.elementAt(selectedIndex),
      // bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex,setBottomBarIndex: setBottomBarIndex,),
      body: Column(children: [
        Expanded(
          flex: 6,
          child: (this.now() == null) ? Container() : this.now(),
        ),
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
