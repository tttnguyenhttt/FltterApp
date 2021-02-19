import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/update.dart';
import 'Info.dart';
import 'admin1.dart';

class editInfo extends StatefulWidget{
  String name;
  editInfo({Key key, this.name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return editInfoState();
  }

}

class editInfoState extends State<editInfo>{

  Item item;
  DatabaseReference itemRef;

  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController takecareController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController longevityController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String ten, i4, tcare, clor, long, hei, wei;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa thông tin'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children:<Widget> [
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index){
                if(snapshot.value['name'] == widget.name){
                  return Form(
                      key: formKey,
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                     /* Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: snapshot.value['name'],
                          // controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tên chủng loại',
                          ),
                          validator: (value) {
                            if(value.isEmpty )
                               {return 'Tên chủng loại không thể để trống';}
                            else {ten = value;}
                          }
                        ),
                      ),*/
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: snapshot.value['info'],
                          //controller: infoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Thông tin',),
                          validator: (value){
                            if(value.isEmpty )
                            {return 'Thông tin không thể để trống';}
                            else {i4 = value;}
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: snapshot.value['take care'],
                          //controller: takecareController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Cách chăm sóc',),
                          validator: (value){
                            if(value.isEmpty )
                            {return 'Cách chăm không thể để trống';}
                            else {tcare = value;}
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: snapshot.value['color'],
                          //controller: colorController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Màu sắc',),
                          validator: (value) {
                            if(value.isEmpty )
                            {return 'Màu sắc không thể để trống';}
                            else {clor = value;}
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: snapshot.value['longevity'],
                          //controller: longevityController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tuổi thọ',),
                          validator: (value){
                            if(value.isEmpty )
                            {return 'Tuổi thọ không thể để trống';}
                            else {long = value;}
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: snapshot.value['height'],
                          //controller: heightController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Chiều cao',),
                          validator: (value){
                            if(value.isEmpty )
                            {return 'Chiều cao không thể để trống';}
                            else {hei = value;}
                          } ,

                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: snapshot.value['weight'],
                          //controller: weightController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Cân nặng ',),
                          validator: (value){
                            if(value.isEmpty )
                            {return 'Cân nặng không thể để trống';}
                            else {wei = value;}
                          },
                        ),
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                              textColor: Colors.white,
                              color: Color(0xff232f34),
                              child: Text('Lưu'),
                              onPressed: () {
                                       if (formKey.currentState.validate()){
                                 itemRef.child(snapshot.key).update({
                                    'info': i4, 'take care': tcare, 'color' : clor, 'longevity': long, 'height': hei, 'weight': wei});
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavDrawer()));
                                        }
                              })
                      ),
                    ],));

                }else {
                  return Text('');
                }
              }
  ,
            ),
          )
        ]
      )
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

