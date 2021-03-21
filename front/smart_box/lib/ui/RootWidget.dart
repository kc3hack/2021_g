import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/ui/BottomNavBar.dart';
import 'package:smart_box/ui/BoxWidgetHolder.dart';
import 'package:smart_box/ui/QrScan.dart';
import 'package:smart_box/ui/qr_print/QrWidgetHolder.dart';

class RootWidget extends StatefulWidget {
  final CognitoUserSession cognitoUserSession;
  RootWidget(this.cognitoUserSession, {Key key}) : super(key: key);

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  static int selectedIndex = 0;

  List<Widget> _routes = [];

  // まだ使っていない _selectedIndexを共有する
  void setBottomBarIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _routes = [
      BoxWidgetHolder(widget.cognitoUserSession),
      QrScan(),
      QrWidgetHolder(widget.cognitoUserSession),
    ];
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
