import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanease/cert/vc_view.dart';
import 'package:scanease/storage_files/myDoc.dart';
import 'package:scanease/vc/vc_view.dart';
import 'package:scanease/vc/vc_view2.dart';
import 'package:scanease/vc/vc_view3.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {



  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  File pickedImage1;
  File pickedImage2;
  bool yes1 = false;
  bool yes2 = false;
  _imagePick1() async {
    pickedImage1 = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: pickedImage1.path,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop/Rotate',
          toolbarColor: Color(0xFF007f5f),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    setState(() {
      pickedImage1 = croppedFile;
      yes1 = true;
    });

  }
  _imagePick2() async {
    pickedImage2 = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile2 = await ImageCropper.cropImage(
      sourcePath: pickedImage2.path,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop/Rotate',
          toolbarColor: Color(0xFF007f5f),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    setState(() {
      pickedImage2 = croppedFile2;
      yes2 = true;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: yes1 && yes2?AppBar(title: Text('Details'),
        actions: <Widget>[

          IconButton(icon: Icon(Icons.done),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cert(name: name.text,date: date.text,image1: pickedImage1,image2: pickedImage2,)));
            },)
        ],):
      AppBar(title: Text('Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyDoc()));
          },
        ),
        ),
      body: Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Center(child: Text('Enter your details',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              SizedBox(height: MediaQuery.of(context).size.height/20,),

              SizedBox(height: MediaQuery.of(context).size.height/20,),
              TextField(
                maxLength: 25,
                controller: name,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,),
              TextField(
                maxLength: 10,
                controller: date,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(hintText: 'Date'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,),
              Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  yes1
                      ?  GestureDetector(
                      onTap: () {
                        _imagePick1();
                      },
                      child: CircleAvatar(radius:MediaQuery.of(context).size.height / 10,backgroundColor: Colors.transparent,
                        child: Image(image: FileImage(pickedImage1),),
                      )
                  )

                      : GestureDetector(
                    onTap: () {
                      _imagePick1();
                    },
                    child: CircleAvatar(radius:MediaQuery.of(context).size.height / 10,backgroundColor: Colors.black45,
                        child: Text(
                          "President's\nSignature",
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        )),
                  ),
                  yes2
                      ?  GestureDetector(
                      onTap: () {
                        _imagePick2();
                      },
                      child: CircleAvatar(radius:MediaQuery.of(context).size.height / 10,backgroundColor: Colors.transparent,
                        child: Image(image: FileImage(pickedImage2),),
                      )
                  )

                      : GestureDetector(
                    onTap: () {
                      _imagePick2();
                    },
                    child: CircleAvatar(radius:MediaQuery.of(context).size.height / 10,backgroundColor: Colors.black45,
                        child: Text(
                          "Dean's\nSignature",
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        )),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}