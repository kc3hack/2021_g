import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_box/baggage/box.dart';
import "package:smart_box/barcode_reader/BarcodeReader.dart";
import 'package:smart_box/server_interface/ServerInterface.dart';
import 'package:smart_box/ui/ItemWidget.dart';

///
/// バーコード読み込みテスト用Widget
///
class QrScan extends StatefulWidget {
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String _scanResult = '';
  Box aBox;

  @override
  void initState() {
    super.initState();
    scanBarcode(ScanMode.QR).then((result) {
      List<String> r = result.split("/");
      getBoxes("").then((boxes) {
        for (Box box in boxes) {
          if (box.id == int.parse(r.last)) {
            setState(() {
              this.aBox = box;
            });
          }
        }
      });
    });
  }

  Future<bool> _onWillPopHandler() async {
    return false;
  }

  ///
  /// 最初のボックスの詳細のWidget
  ///
  Widget _makeBoxDescription() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: Text(
              aBox.boxName,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: Text(
              aBox.description,
              style: TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeScaffold() {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: StaggeredGridView.extentBuilder(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              maxCrossAxisExtent: 200,
              itemCount: this.aBox.items.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) return this._makeBoxDescription();
                if (index == this.aBox.items.length + 1) return Container();
                return ItemWidget(this.aBox.items[index - 1]);
              },
              staggeredTileBuilder: (int index) => StaggeredTile.extent(
                  (index == 0) ? 100 : 1, (index == 0) ? 150 : 170),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("アイテム一覧"),
        actions: [
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 40,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  print("search button pushed");
                },
              ))
        ],
      ),
      body: (this.aBox == null) ? Container() : this._makeScaffold(),
    );
  }
}
