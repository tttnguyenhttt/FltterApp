import 'package:flutter/material.dart';
import 'screens/chose_imageic.dart';

void main() {
  runApp(

      MaterialApp(
        home: BottomNavDrawer(),
      ));
}

class Home extends StatelessWidget{
@override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blueGrey,
    appBar: AppBar(

    ),
  );
}
}
