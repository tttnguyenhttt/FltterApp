import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app1/screens/admin1.dart';

final FirebaseApp app = initializeApp(
    options: FirebaseOptions(
      googleAppID: '1:650553034034:android:789fd8c6bc89a5f086032b',
      apiKey:'AIzaSyC_cm-Ai71dkZ3JU-EYMAJlRGgDF-8KT2w',
      databaseURL: 'https://doggie-app-48e12.firebaseio.com',
    )
);

FirebaseApp initializeApp({FirebaseOptions options}) {}

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
  
}

 class LoginState extends State<Login>{

   String username;
   String password;

   List<User> users = List();
   User user;
   DatabaseReference userRef;

   final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void initState() {
       super.initState();
      user = User("","","");
      final FirebaseDatabase database = FirebaseDatabase.instance;
      userRef = database.reference().child('user');
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Đăng nhập'),
          backgroundColor: Colors.blueGrey[900],
    ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: FirebaseAnimatedList(
                query: userRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                    return Form(
                        key: formKey,
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Tên đăng nhập',),
                                validator: (value) => value.isEmpty ? 'Tên đăng nhập không thể để trống' : null),),
                          Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mật khẩu ',),
                                  validator: (value) => value.isEmpty ? 'Mật khẩu không thể để trống' : null)),

                          Container(
                              height: 50,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xff232f34),
                                child: Text('Đăng nhập'),
                                onPressed: () {
                                  if (formKey.currentState.validate()){
                                    if(nameController != null && nameController.text == snapshot.value['username']
                                        && passwordController != null && passwordController.text == snapshot.value['password']){
                                      try{
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavDrawer()));
                                      }
                                      catch(e){
                                        print(e.message);
                                        print(nameController.text);
                                        print(passwordController.text);
                                      }
                                    }
                                  }

                                })
                                  ),
                        ]
                    ));
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
     user = User("","","");
     final FirebaseDatabase database = FirebaseDatabase.instance;
     userRef = database.reference().child('user');
   }


   void handleSubmit() {
     final FormState form = formKey.currentState;

     if (form.validate()) {
       form.save();
       form.reset();
       userRef.push().set(user.toJson());
     }
   }


 }



  class User{
  String key;
  String username;
  String password;

  User(this.key,this.username,this.password);

  User.fromSnapShot(DataSnapshot snapshot)
    : key = snapshot.key,
      username = snapshot.value['username'],
      password = snapshot.value['password'];
  toJson() => {
    "password": password,
    "username": username,
  };}