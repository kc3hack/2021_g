import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_box/auth/WebViewWidget.dart';

void main() async {
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.mPLUS1pTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Colors.white,
        accentColor: Colors.cyan,
        scaffoldBackgroundColor: Color.fromARGB(255, 236, 242, 242),
      ),
      home: WebViewWidget(),
    );
  }
}
