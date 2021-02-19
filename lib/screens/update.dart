import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/editInfo.dart';


import 'Info.dart';


final FirebaseApp app = initializeApp(
    options: FirebaseOptions(
      googleAppID: '1:650553034034:android:789fd8c6bc89a5f086032b',
      apiKey:'AIzaSyC_cm-Ai71dkZ3JU-EYMAJlRGgDF-8KT2w',
      databaseURL: 'https://doggie-app-48e12.firebaseio.com',
    )
);

FirebaseApp initializeApp({FirebaseOptions options}) {}


class Update extends StatefulWidget{
  @override
  UpdateState createState() {
    return new UpdateState();
  }

}
class UpdateState extends State<Update>{

  Item item;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật thông tin '),
        backgroundColor: Colors.blueGrey[900],
      ),
    body: Column(
      children: <Widget>[
        Flexible(
          child: FirebaseAnimatedList(
            query: itemRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Table(
                       // border: TableBorder.all(),
                        children: [
                          TableRow( children: [
                            Row(children:[
                              Center(child: Text( snapshot.value['name'] ,style: TextStyle(fontSize: 20.0,),
                                textAlign: TextAlign.center,
                              ),

                              ),
                              //Icon(Icons.edit, size: 20.0,),
                              ],

                    ),
                            Container(
                              padding: EdgeInsets.fromLTRB(40,0,10,0),
                              child:

                            RaisedButton(

                              child: Icon(Icons.edit,size: 20.0),
                              onPressed: () {
                                //String name = snapshot.value['name'];
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> editInfo(name: snapshot.value['name'])));
                            }),
                        ),
                          ]),
                        ],
                      ),
                    ),
                    ],);
            },
          ),
        )
    ]
    ),
    );

}
  void initState() {
    super.initState();
    item = Item("","","","","","","","","");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('loai');
    //itemRef.onChildAdded.listen(_onEntryAdded);
    //itemRef.onChildChanged.listen(_onEntryChanged);
  }
}

