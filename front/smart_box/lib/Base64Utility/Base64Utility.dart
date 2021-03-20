import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

///
/// base64文字列からImageへ変換する
///
/// 例外が発生した場合はnull
///
Image base64ToImage(String aBase64String) {
  Image aImage;
  try {
    Uint8List bytes = base64.decode(aBase64String);
    aImage = Image.memory(bytes);
  } catch (exception) {
    print(exception);
  }
  return aImage;
}

///
/// 画像からbase64文字列に変換する
///
/// 例外発生時は空文字列
///
String imageToBase64(File imageFile) {
  String base64String;
  try {
    List<int> imageByte = imageFile.readAsBytesSync();
    base64String = base64.encode(imageByte);
  } catch (exception) {
    print(exception);
    return "";
  }
  print(base64String);
  print(base64String.length);
  return base64String;
}
