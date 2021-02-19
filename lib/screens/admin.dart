import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/update.dart';
import 'package:image_picker/image_picker.dart';

import 'chose_imageic.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget> [
          DrawerHeader(
              decoration: BoxDecoration(

                  gradient: LinearGradient(
                      colors: <Color>[
                        Colors.blueGrey[900],
                        Color(0xff344955)
                      ])
              ),
              child: Container(
                child: Column(

                  children: <Widget>[

                    /* CircleAvatar(
                    backgroundImage: AssetImage('images/ic_doggie.png'),
                    radius: 100,
                  ),*/
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(padding: EdgeInsets.all(8.0),
                        child: Image.asset('images/ic_doggie.png', width: 80, height: 80,), ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Admin', style: TextStyle(color: Colors.white, fontSize: 20.0),

                      ),
                    ),
                  ],
                ),
              )
          ),
          CustomListTile(Icons.update, 'Cập nhật',()=>{
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Update()
          ),
          ),
          }),
          // CustomListTile(Icons.notifications, 'Notification',()=>{}),
          // CustomListTile(Icons.settings,'Settings',()=>{}),
          CustomListTile(Icons.lock,'Đăng xuất',()=>{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavDrawer()
              ),
            ),
          }),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget{
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text,this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
        child: InkWell(
          splashColor: Color(0xff344955),
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text, style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

}