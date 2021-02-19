import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter_app1/widgets/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
class video extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return videoState();
  }
  
}
class videoState extends State<video>{

  @override
  Widget build(BuildContext context) {
    Future<void> main() async {
      // Ensure that plugin services are initialized so that `availableCameras()`
      // can be called before `runApp()`
      WidgetsFlutterBinding.ensureInitialized();

      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();

      // Get a specific camera from the list of available cameras.
      final firstCamera = cameras.first;

      runApp(
        MaterialApp(
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color(0xFFFF00FF),
          ),
          theme: ThemeData.dark(),
          home: Home(
            // Pass the appropriate camera to the TakePictureScreen widget.
            camera: firstCamera,
          ),
        ),
      );
    }
  }
}