
import 'dart:io';

import 'package:certificate_generator/cert/generate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/cupertino.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;


class share extends StatefulWidget {
  final img;
  share({this.img});
  @override
  _shareState createState() => _shareState();
}

class _shareState extends State<share> {
  @override
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  initState() {
    super.initState();

  }

  String _uploadedFileURL;
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('cert/${Path.basename(widget.img.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(widget.img);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GenerateScreen(img: _uploadedFileURL,)));

      });
    });
  }
  final pdf = pw.Document();


  @override
  Widget build(BuildContext context) {
    File _image = widget.img;
    Future<void> choiceAction(String choice) async {
      if(choice == Constants.Share){
        var sh = widget.img
            .readAsBytesSync();
        await Printing.sharePdf(
            bytes: sh, filename: 'vc.png');
      }else if(choice == Constants.Rename){



      }else if(choice == Constants.delete){
        uploadFile();

      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Share'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Image.file(widget.img),
        ),
      ),
    );
  }

}
class Constants{
  static const String Share = 'Share as Image';
  static const String Rename = 'Share as PDF';
  static const String delete = 'Share as Barcode';

  static const List<String> choices = <String>[
    Share,
    Rename,
    delete,
  ];
}
