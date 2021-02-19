import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';


final FirebaseApp app = initializeApp(
    options: FirebaseOptions(
      googleAppID: '1:650553034034:android:789fd8c6bc89a5f086032b',
      apiKey:'AIzaSyC_cm-Ai71dkZ3JU-EYMAJlRGgDF-8KT2w',
      databaseURL: 'https://doggie-app-48e12.firebaseio.com',
  )
);
FirebaseApp initializeApp({FirebaseOptions options}) {}

class Info extends StatefulWidget{
  Info({Key key, this.label});
   String label ;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InfoState();
  }

}


class InfoState extends State<Info>{
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin chủng loại'),
        backgroundColor: Colors.blueGrey[900],
      ),

      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[

                  ],
                ),
              )
            ),
          ),
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                if (snapshot.value['name'] == widget.label) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      child: Center(child: Image.asset('images/'+ snapshot.value['image'],
                        ),
                    ),),


                    Container(
                      child: Center(  child: Text(snapshot.value['name'], style: TextStyle(fontSize: 30.0),
                        ),),

                    ),
                    Container(
                      child: Center(child:Text('\nTHÔNG TIN', style: TextStyle(fontSize: 20.0, color: Colors.red), textAlign: TextAlign.center),
                    )),
                    Container(
                      child:Center(child: Text(snapshot.value['info'], style: TextStyle(fontSize: 20.0),),
                    )),
                    Container(
                        child:Center(child: Text('\nCHIỀU CAO', style: TextStyle(fontSize: 20.0, color: Colors.red), textAlign: TextAlign.center),
                        )),
                    Container(
                        child:Center(child: Text(snapshot.value['height'],style: TextStyle(fontSize: 20.0),),
                        )),
                    Container(
                        child:Center(child: Text('\nCÂN NẶNG', style: TextStyle(fontSize: 20.0, color: Colors.red), textAlign: TextAlign.center),
                        )),
                    Container(
                        child:Center(child: Text(snapshot.value['weight'],style: TextStyle(fontSize: 20.0),),
                        )),
                    Container(
                        child:Center(child: Text('\nTUỔI THỌ', style: TextStyle(fontSize: 20.0, color: Colors.red), textAlign: TextAlign.center),
                        )),
                    Container(
                        child:Center(child: Text(snapshot.value['longevity'],style: TextStyle(fontSize: 20.0),),
                        )),
                    Container(
                        child:Center(child: Text('\nMÀU SẮC', style: TextStyle(fontSize: 20.0, color: Colors.red), textAlign: TextAlign.center),
                        )),
                    Container(
                      child: Text(snapshot.value['color'],style: TextStyle(fontSize: 20.0),),
                    ),
                    Container(
                      child:Center(child: Text('\nCÁCH CHĂM SÓC', style: TextStyle(fontSize: 20.0, color: Colors.red), textAlign: TextAlign.center),
                    )),
                    Container(
                      child:Center(child: Text(snapshot.value['take care'],style: TextStyle(fontSize: 20.0),),
                    )),

                  ]
                );
                }else {
                  return Text('');
                }

              },
            ),
          ),
        ],
      ),
    );
  }

    // TODO: implement build
    void initState() {
      super.initState();
      item = Item("","","","","","","","","");
      final FirebaseDatabase database = FirebaseDatabase.instance;
      itemRef = database.reference().child('loai');
      //itemRef.onChildAdded.listen(_onEntryAdded);
      //itemRef.onChildChanged.listen(_onEntryChanged);
    }

    void handleSubmit() {
      final FormState form = formKey.currentState;

      if (form.validate()) {
        form.save();
        form.reset();
        itemRef.push().set(item.toJson());
      }
    }


  }


class Item {
  String key;
  String name;
  String info;
  String takecare;
  String height;
  String color;
  String longevity;
  String weight;
  String image;




  Item(this.name, this.info, this.color, this.height, this.key, this.longevity, this.takecare, this.weight, this.image);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        image = snapshot.value["image"],
        name = snapshot.value["name"],
        info = snapshot.value["info"],
        takecare = snapshot.value["take care"],
        height = snapshot.value["height"],
        weight = snapshot.value["weight"],
        color = snapshot.value["color"],
        longevity = snapshot.value["longevity"];

  toJson() => {
      "image": image,
      "name": name,
      "info": info,
      "take care": takecare,
      "height": height,
      "weight":weight,
      "color": color,
      "longevity": longevity,
    };}