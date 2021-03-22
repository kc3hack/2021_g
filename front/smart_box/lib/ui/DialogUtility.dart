import 'package:flutter/material.dart';

Future showErrorDialog(BuildContext context, String title,
    {String content = ""}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      });
}

Future showNormalDialog(BuildContext context, String title,
    {String content = ""}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      });
}
