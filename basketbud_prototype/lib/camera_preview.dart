import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

//preview image
class CamPreview extends StatefulWidget {
  CamPreview(this.file, {super.key});
  XFile file;
  @override
  State<CamPreview> createState() => _CamPreviewState();
}

class _CamPreviewState extends State<CamPreview> {
  @override
  Widget build(BuildContext context) {
    File imageCaptured = File(widget.file.path);
    return Scaffold(
      appBar: AppBar(title: const Text('Image preview')),
      body: Center(
        child: Image.file(imageCaptured),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check_circle),
          onPressed: () {
            print("Saving image.");
          }),
    );
  }
}
