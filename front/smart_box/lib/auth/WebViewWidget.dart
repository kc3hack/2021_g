import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_box/ui/RootWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://smartbox.yukiho.dev/',
      onPageFinished: (url) {
        if (url == "https://smartbox.yukiho.dev/") {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return RootWidget();
          }));
        }
      },
    );
  }
}
