import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import 'package:smart_box/StringUtility/StringUtility.dart';
import 'package:smart_box/baggage/box.dart';
import 'package:smart_box/ui/BottomNavBar.dart';
import 'package:smart_box/ui/BoxListWidget.dart';
import 'package:smart_box/ui/ItemListWidget.dart';
import 'package:smart_box/ui/QrScan.dart';
import "package:smart_box/ui/WidgetHolder.dart";
import 'package:smart_box/ui/qr_print/SelectBoxWidget.dart';
import 'package:uni_links/uni_links.dart';

class RootWidget extends StatefulWidget {
  RootWidget({Key key}) : super(key: key);

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends WidgetHolderState<RootWidget> {
  int selectedIndex = 0;

  ///
  /// ボトムバーで選択されたWidgetを始める
  ///
  void setBottomBarIndex(index) {
    this.selectedIndex = index;
    switch (index) {
      case 0:
        this.startNewWidget(BoxListWidget(this));
        break;
      case 1:
        QrScan.scanQr(this);
        break;
      case 2:
        super.startNewWidget(SelectBoxWidget(this));
        break;
      default:
        break;
    }
  }

  ///
  /// DeepLinkの処理
  ///
  Future<Null> initUniLinks() async {
    try {
      String initialLink = await getInitialLink();
      if (initialLink != null && validateQrString(initialLink)) {
        Box aBox = await getBoxFromQrLink(initialLink);
        if (aBox != null) {
          this.add(ItemListWidget(aBox, this));
        }
      }
    } on PlatformException {}
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.startNewWidget(BoxListWidget(this));
    this.initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    if (this.now() == null) this.add(BoxListWidget(this));
    return Scaffold(
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
