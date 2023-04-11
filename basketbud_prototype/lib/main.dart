import 'package:basketbud_prototype/camera_start.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //ensure initialized
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  //helper function for bottom navbar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    page = const Placeholder();
    return MaterialApp(
      //create home page
      home: Scaffold(
        //add appbar on top
        appBar: AppBar(
          //set properties
          backgroundColor: Colors.teal,
          title: const Text('BasketBud'),
        ),
        //add a floating button for camera
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera),
          onPressed: () {
            //call camera from IO
            print('Calling Camera');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraStart()),
            );
          },
        ),
        //add navigation bar on bottom
        bottomNavigationBar: BottomNavigationBar(
          //navigation items
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pages),
              label: 'Flyers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: "Receipts",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber,
          onTap: (value) {
            print('Selected $value');
            _onItemTapped(value);
          },
        ),
        body: page,
      ),
    );
  }
}
