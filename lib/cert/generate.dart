
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class GenerateScreen extends StatefulWidget {
  final img;
  GenerateScreen({this.img});

  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  var docsPath;
  void getDocument() async {
    var pa = await getExternalStorageDirectory();
    print("Initial Parent Path " +
        pa.path.substring(0, pa.path.indexOf('files')));
    setState(() {
      docsPath = pa.path.substring(0, pa.path.indexOf('files'));
    });
  }
  initState() {
    super.initState();
    getDocument();
  }

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString;
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    _dataString = widget.img;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Ease'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
              _captureAndSharePng();
            }
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
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

      var sh =
          image
          .readAsBytesSync();
      await Printing.sharePdf(
          bytes: sh, filename: 'QR.png');

    }).catchError((onError) {
      print(onError);
    });
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        children: <Widget>[
          Expanded(
            child:  Center(
              child: Screenshot(
                controller: screenshotController,
                child: Container(color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: _dataString,
                        size: 0.4 * bodyHeight,
                      ),
                    ),
                  ),
                )
              )
            ),
          ),
        ],
      ),
    );
  }
}