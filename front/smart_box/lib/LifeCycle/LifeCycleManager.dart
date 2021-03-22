import 'package:flutter/services.dart';

final String resume = "AppLifecycleState.resumed";

void onResume(Function function) {
  SystemChannels.lifecycle.setMessageHandler((message) {
    if (message == resume) {
      function();
    }
    return Future<String>.value();
  });
}
