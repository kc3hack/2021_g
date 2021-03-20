import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_box/ui/root.dart';

void main() {
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
      home: RootWidget(),
    );
  }
}
