import 'dart:io';

import 'package:path_provider/path_provider.dart';

//get save path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

//get reference to file path (appened file name)
Future<File> get _localFile async {
  final path = await _localPath;
  //currently will overwrite
  return File('$path/test_image.jpg');
}

//write to path
Future<File> saveImage(File image) async {
  final file = await _localFile;
  print("Saving image.");
  //"/data/user/0/com.example.basketbud_prototype/app_flutter/test_image.jpg"
  //path is only accessible with root access or opened via Android Studio
  print(file.path);
  // Write the file
  return image.copy(file.path);
}
