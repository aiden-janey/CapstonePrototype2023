import 'package:basketbud_prototype/camera_preview.dart';
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

  //building camera stream widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //allow camera preview to fill available space
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: CameraPreview(_controller),
                ),
              ),
            ),
          ),
          //button for initiating image capture
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Center(
              child: IconButton(
                color: Colors.amber,
                onPressed: () async {
                  //check if camera controller is initialized or busy
                  if (!_controller.value.isInitialized ||
                      _controller.value.isTakingPicture) {
                    return;
                  }

                  // Store the current context in a variable
                  final currentContext = context;

                  //try catch taking an image
                  try {
                    await _controller.setFlashMode(FlashMode.auto);
                    //save image to file
                    XFile file = await _controller.takePicture();
                    print("Image captured.");

                    // Use Future.microtask to execute the Navigator.push() after the current build method
                    Future.microtask(() {
                      Navigator.push(
                        currentContext, // Use the stored context
                        MaterialPageRoute(
                          builder: (context) => CamPreview(file),
                        ),
                      );
                    });
                  } on CameraException catch (e) {
                    debugPrint("Error capturing image: $e");
                  }
                },
                icon: const Icon(Icons.circle),
                iconSize: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
