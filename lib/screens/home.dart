import 'dart:io';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:certificate_generator/providers/home.dart';
import 'package:certificate_generator/utils/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:certificate_generator/cert/cert/cert.dart';
import 'package:certificate_generator/cert/cert/cert2.dart';
import 'package:certificate_generator/cert/cert/cert3.dart';
import 'package:certificate_generator/cert/cert/cert4.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
@override
  void initState() {
    // TODO: implement initState
    AlanVoice.addButton("9c9c3e8d917e96cca20b9fc7f80609482e956eca572e1d8b807a3e2338fdd0dc/stage",
    buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,
    );
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
     void showPreviewDialog(List<dynamic> s) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen())),
        child: Container(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(40,100,40,100),
                child: Column(
                  children: <Widget>[
                    Card(color: Colors.black54,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Select Template',style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: <Widget>[
                          GestureDetector(
                            child: Card(color: Colors.white,
                                child: Image.asset('assets/cert1.png')
                            ),
                            onTap: (){
                               
                                                              Navigator.pushNamed(context, '/cert',
                                                                       arguments: {'result': s});
                            },
                          ),
                          GestureDetector(
                            child: Card(color: Colors.white,
                                child: Image.asset('assets/cert2.png')
                            ),
                            onTap: (){
                            
                                                              Navigator.pushNamed(context, '/cert1',
                                                                       arguments: {'result': s});
                            },
                          ),
                          GestureDetector(
                            child: Card(color: Colors.white,
                                child: Image.asset('assets/cert3.png')
                            ),
                            onTap: (){
                             
                                                              Navigator.pushNamed(context, '/cert2',
                                                                       arguments: {'result': s});
                            },
                          ),
                          GestureDetector(
                            child: Card(color: Colors.white,
                                child: Image.asset('assets/cert4.png')
                            ),
                            onTap: (){
                               Navigator.pushNamed(context, '/cert3',
                                                                       arguments: {'result': s});
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                )
            )
        ),

      ),
    );
     }
    return Consumer<HomeProvider>(
      builder: (_, homeProvider, __) => Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          
          title: Text('Cert-Maker'),
          actions: <Widget>[
          Builder(builder: (BuildContext context) {
//5
            return IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                final FirebaseUser user = await _auth.currentUser();
                if (user == null) {
//6
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                await _auth.signOut();
                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
              },
            );
          })
        ],
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          centerTitle: true,
          bottom: homeProvider.xlsxFilePath != null
              // shows drop-down populated with tables from selected xlsx file
              ? PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    child: DropdownButtonFormField(
                      value: homeProvider.xlsxFileSelectedTable,
                      onChanged: (newXlsxFileSelectedTable) {
                        homeProvider.xlsxFileSelectedTable =
                            newXlsxFileSelectedTable;
                      },
                      items: [
                        ...homeProvider.xlsxFileTables.keys.map(
                          (table) => DropdownMenuItem(
                            child: Text(table),
                            value: table,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : PreferredSize(
                  child: Container(),
                  preferredSize: Size.fromHeight(0),
                ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            homeProvider.xlsxFilePath != null
                ? FloatingActionButton(
                    heroTag: 'Share',
                    onPressed: () async {
                      // retrieves all names from selected table
                      final names = homeProvider
                          .xlsxFileTables[homeProvider.xlsxFileSelectedTable]
                          .rows
                          .map((name) => name
                              .toString()
                              .substring(1, name.toString().length - 1));

                      // generates all certificates from selected table
                      names.forEach((name) => pdfGenerator(name));
                      final String downloadPath =
                          await getApplicationDocumentsDirectoryPath();

                      // retrieves file paths of all certificates from selected table
                      final files = names
                          .map((name) => File('$downloadPath/$name.pdf').path);

                      // shares all certificate from table via selected app
                      await ShareExtend.shareMultiple([
                        ...files,
                      ], 'file');
                    },
                    child: Icon(Icons.share),
                  )
                : Container(),
          
            SizedBox(
              height: 30,
            ),
            FloatingActionButton(
              heroTag: 'Attach',
              onPressed: () async {
                homeProvider.xlsxFilePath = await FilePicker.getFilePath(
                  type: FileType.CUSTOM,
                  fileExtension: 'xlsx',
                  
                );
                homeProvider.xlsxFileTables = SpreadsheetDecoder.decodeBytes(
                        File(homeProvider.xlsxFilePath).readAsBytesSync())
                    .tables;
              },
              child: Icon(Icons.attach_file),
            ),
          ],
        ),
        body: Center(
          child: homeProvider.xlsxFilePath != null
              ? ListView(
                  padding: EdgeInsets.all(16),
                  children: <Widget>[
                    // reads names from selected table from spreadsheet and displays them in list
                    ...SpreadsheetDecoder.decodeBytes(
                            File(homeProvider.xlsxFilePath).readAsBytesSync())
                        .tables[homeProvider.xlsxFileSelectedTable]
                        .rows
                        .map(
                          (value) => Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListTile(
                                  subtitle: Text(
                                    'Tap to view more',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: FutureBuilder(
                                    future:
                                        getApplicationDocumentsDirectoryPath(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        // shows download icon if file doesn't exist else shows checked icon
                                        return Container(
                                          margin: EdgeInsets.all(8),
                                          child:
                                              File('${snapshot.data}/${value.toString().substring(1, value.toString().length - 1)}.pdf')
                                                      .existsSync()
                                                  ? Icon(
                                                      Icons.check,
                                                      color: Colors.black,
                                                    )
                                                  : Icon(
                                                      Icons.file_download,
                                                      color: Colors.black,
                                                    ),
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(16),
                                  onTap: () {

                              showPreviewDialog(value);
                                  },
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.deepPurple[200],
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.deepPurple[100],
                                      size: 30,
                                    ),
                                  ),
                                  title: Text(
                                    value[0],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                  ],
                )
              : Center(
                  child: Text(
                    'Click FAB to read xlsx',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
        ),
      ),
    );
  }
}
