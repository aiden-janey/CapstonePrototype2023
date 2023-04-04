import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

//late init camera devices
late List<CameraDescription> cameras;

class CameraStart extends StatefulWidget {
  const CameraStart({super.key});

  @override
  State<CameraStart> createState() => _CameraStartState();
}

class _CameraStartState extends State<CameraStart> {
  late CameraController _controller;
  //initializing camera controllers
  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      //check if not mounted
      if (!mounted) {
        return;
      }
      //refresh widget app
      setState(() {});
    }).catchError((Object e) {
      //check error on accessing camera
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            debugPrint("Please allow access to camera.");
            break;
          default:
            debugPrint(e.description);
            break;
        }
      }
    });
  }

  //free camera widget on exit
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //building camera stream widiget
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
