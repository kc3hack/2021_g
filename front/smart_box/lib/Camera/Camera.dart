import "package:image_picker/image_picker.dart";

///
/// カメラに関するUtility
///
/// AndroidManifestに以下の権限を付与する必要あり
///     <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
///     <uses-permission android:name="android.permission.CAMERA"/>
///     <uses-permission android:name="android.hardware.camera.autofocus"/>
///     <uses-permission android:name="android.permission.WAKE_LOCK"/>

///
/// カメラで撮影し、保存した画像のパスを返す
///
Future<String> takePicture() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.camera);
  if (pickedFile == null) {
    print('No image selected.');
    return "";
  }

  return pickedFile.path;
}
