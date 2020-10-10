import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../share.dart';

class Cert2 extends StatefulWidget {
  String name;
  String rank;
  String project;
  Cert2({Key key, @required this.name,@required this.rank,@required this.project}) : super(key: key);

  @override
  _Cert2State createState() => _Cert2State();
}

class _Cert2State extends State<Cert2> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  initState() {
    super.initState();
    getDocument();
  }
  var docsPath;
  void getDocument() async {
    var pa = await getExternalStorageDirectory();
    print("Initial Parent Path " +
        pa.path.substring(0, pa.path.indexOf('files')));
    setState(() {
      docsPath = pa.path.substring(0, pa.path.indexOf('files'));
    });
  }


  File _imageFile;
  Future onSelectNotification(String payload) async {
    OpenFile.open(_imageFile.path);
  }
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificate'),
        actions: <Widget>[
          FlatButton(
              child: new Text("Save"),
              onPressed: () {

                _imageFile = null;
                screenshotController
                    .capture(
                    delay: Duration(milliseconds: 500), pixelRatio: 1.5)
                    .then((File image) async {
                  //print("Capture Done");
                  setState(() {
                    _imageFile = image;
                  });
                  var dir = '$docsPath';
                  image.copy(dir +
                      '/' +
                      DateTime.now().millisecondsSinceEpoch.toString() +
                      '.png');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => share(img: image,)));
                }).catchError((onError) {
                  print(onError);
                });

              }),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width ,
          child: Center(
              child: Container(height: MediaQuery.of(context).size.height/2 ,
                width:MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/cert2.png'),fit: BoxFit.fill)
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: MediaQuery.of(context).size.height/20),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(widget.name,
                                  style: TextStyle(fontSize: 25,color: Colors.indigo[400] ,fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/55),
                              Padding(
                                padding: const EdgeInsets.only(right: 70),
                                child: Text(widget.rank,
                                  style: TextStyle(fontSize: 8,color: Colors.black),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/60),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Text(widget.project,
                                  style: TextStyle(fontSize: 10,color: Colors.black),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/22),
                            ],
                          ),
                        ),
                      ],
                    )
                ),

              )
          ),
        ),
      ), );


  }
}
