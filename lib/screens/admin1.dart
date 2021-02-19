import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/admin.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import 'Info.dart';
import 'package:flutter_app1/widgets/home.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';

File imageFile;
bool _loading = false;
List _outputs;
bool _uploaded = false;
const String ssd = "SSD MobileNet";

class BottomNavDrawer extends StatefulWidget {
  @override


  BottomNavDrawerState createState() {
    return new BottomNavDrawerState();
  }
}

class BottomNavDrawerState extends State<BottomNavDrawer> {
  String model = ssd;
//File imageFile;
  double imageWidth;
  double imageHeight;

  classifyImage() async{

    await Tflite.loadModel(
      model: "assets/tflite/model.tflite",
      labels: "assets/tflite/labels.txt",
      numThreads: 1,
    );
    var output =  await Tflite.runModelOnImage(
        path: imageFile.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 1,
        threshold: 0.2,
        asynch: true
    );

    this.setState(() {
      // _loading = false;
      _outputs = output;
      print(_outputs);
    });
    print(_outputs);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MyNextPage(),
      ),);
  }



  _openCamera() async{
    var picture = await ImagePicker.pickImage( source: ImageSource.camera);
    this.setState((){
      //_loading = true;
      imageFile = picture;
      //
      // print('3');
      // print(_outputs);
      //  uploadImageToFirebase(this.context);
    });

    classifyImage();
    print(_outputs);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         MyNextPage(),
    //   ),);


  }

  _openGallery() async {
    var picture = await ImagePicker.pickImage( source: ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    print(imageFile.path);
    classifyImage();
  }
  @override
  Future navigateToVideo(context,x) async =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(camera: x)));
  _loadVideo() async {
    WidgetsFlutterBinding.ensureInitialized();

    final cameras = await availableCameras();

    final firstCamera = cameras.first;
    setState(() {
      navigateToVideo(context,firstCamera);
    });
  }

  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('image.jpg');
  @override
  Future uploadImageToFirebase() async {
    String name = _outputs[0]['label'];

    //StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('image.jpg');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState((){
      _uploaded = true;
      print(imageFile.path);
    });
  }

  _showDrawer(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
              color: Color(0xff232f34),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 36,
                ),
                SizedBox(
                    height: (44 * 6).toDouble(),
                    width: 400.0,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          color: Color(0xff344955),
                        ),
                        child: Stack(
                          alignment: Alignment(0, 0),
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              top: -36,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(
                                        color: Color(0xff232f34), width: 10)),

                              ),
                            ),
                            Positioned(
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  ListTile(
                                      title: MaterialButton(
                                        color: Color(0xff344955),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                " Camera",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          _openCamera();
                                        },
                                      )
                                  ),
                                  ListTile(
                                      title: MaterialButton(
                                        color: Color(0xff344955),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.add_photo_alternate,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                " Cuộn Camera",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          _openGallery();
                                        },
                                      )
                                  ),
                                  ListTile(
                                      title: MaterialButton(
                                        color: Color(0xff344955),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.camera,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                " Trực tiếp",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        onPressed: () { _loadVideo();
                                        },
                                      )
                                  ),
                               /*   ListTile(
                                      title: MaterialButton(
                                        color: Color(0xff344955),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.history,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                " Lịch sử",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        onPressed: () {},
                                      )
                                  ),*/
                                ],
                              ),
                            )
                          ],
                        ))),
                Container(
                  height: 0,
                  color: Color(0xff4a6572),
                )
              ],
            ),
          );
        });
  }
  _createAlertDialog(BuildContext context){
    return showDialog(context: context, builder:(context){
      return AlertDialog(
          title: Column(children:[ Text('Ứng dụng sử dụng cho việc nhận dạng các chủng loại chó áp dụng cho các cơ sở thú y hoặc những người muốn tìm hiểu thông tin về các chủng loại chó'),
            Text('Phiên bản: DOGGIE 1.0', textAlign: TextAlign.left),
            Text('Ngày phát hành: 12/12/2020')
          ]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DOGGIE',
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info),
              iconSize: 36,
              color: Colors.white,
              onPressed: () {
                _createAlertDialog(context);
              }
          ),
        ],
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[900],
        child: Icon(
            Icons.camera_alt),
        onPressed: _showDrawer,
      ),
      body: Image(
        image: AssetImage('images/hinhnen.png'),
        width:MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class MyNextPage extends StatefulWidget{
//  final String data;

  // const NextPage({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NextPage();
  }}


class NextPage extends State<MyNextPage> {

//  final String data;

  // const NextPage({Key key, this.data}) : super(key: key);
  @override
  void initState() {
    super.initState();
    // _loading = true;
    // loadModel();
    //     .then((val) {
    //   setState(() {
    //     _loading = false;
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'DOGGIE',
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
      ),

      body: new ListView(
        children: <Widget>[
          // _loading ? Container(
          //   height: 300,
          //   width: 300,
          // ) :
          Container(
            margin: EdgeInsets.all(20),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                imageFile == null ? Container() : Image.file(imageFile),
                SizedBox(
                  height: 20,
                ),
                imageFile == null
                    ? Container() :
                _outputs != null ?
                Text(_outputs[0]['label'],
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ) : Container(child: Text("Lỗi"))
              ],
            ),
          ),
          new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xff232f34),
                          Color(0xff344955),
                          Color(0xff344955),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child:
                    const Text('Thông tin', style: TextStyle(fontSize: 20)),
                  ),
                  onPressed: () {
                    String name = _outputs[0]['label'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Info(label:name)
                      ),
                    );
                    // uploadImageToFirebase();
                  }
              ),

            ],

          ),
        ],
      ),
    );
  }


}


