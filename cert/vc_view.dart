import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanease/vc/share.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';

class Cert extends StatefulWidget {
  String name;
  String date;
  File image1;
  File image2;
  Cert({Key key, @required this.name,@required this.date,@required this.image1,@required this.image2}) : super(key: key);

  @override
  _CertState createState() => _CertState();
}

class _CertState extends State<Cert> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  initState() {
    super.initState();
    getDocument();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android, iOS);

     flutterLocalNotificationsPlugin.initialize(initSettings,
     onSelectNotification: onSelectNotification);
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


  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Success',
      'Certificate has been downloaded successfully!',
      platformChannelSpecifics,
    );
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
              textColor: Colors.white,
              onPressed: () {
                _showNotificationWithDefaultSound();

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
          width:MediaQuery.of(context).size.height ,
          child: Center(
              child: Container(height: MediaQuery.of(context).size.height/2 ,
                width:MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/cert.jpg'),fit: BoxFit.fill)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: MediaQuery.of(context).size.height/5.2),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(widget.name,
                                style: TextStyle(fontSize: 25,color: Colors.redAccent,fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/15),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(widget.date,
                                style: TextStyle(fontSize: 11,color: Colors.indigo),
                              ),
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: MediaQuery.of(context).size.width/20,),
                                Container(height: MediaQuery.of(context).size.height/10 ,
                                  width:MediaQuery.of(context).size.width/8 ,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: FileImage(widget.image1),)
                                  ),),
                                SizedBox(width: MediaQuery.of(context).size.width/6,),
                                Container(height: MediaQuery.of(context).size.height/10 ,
                                  width:MediaQuery.of(context).size.width/8 ,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: FileImage(widget.image2),)
                                  ),),
                              ],
                            )
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
