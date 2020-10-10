import 'dart:io';

import 'package:flutter/material.dart';

import 'cert.dart';
import 'cert2.dart';
import 'cert3.dart';
import 'cert4.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  TextEditingController name = TextEditingController();
  TextEditingController rank = TextEditingController();
  TextEditingController project = TextEditingController();

  void showPreviewDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detail())),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cert(name: name.text,rank: rank.text,project: project.text,)));
                            },
                          ),
                          GestureDetector(
                            child: Card(color: Colors.white,
                                child: Image.asset('assets/cert2.png')
                            ),
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cert2(name: name.text,rank: rank.text,project: project.text,)));
                            },
                          ),
                          GestureDetector(
                            child: Card(color: Colors.white,
                                child: Image.asset('assets/cert3.png')
                            ),
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cert3(name: name.text,rank: rank.text,project: project.text,)));
                            },
                          ),
                          GestureDetector(
                            child: Card(color: Colors.white,
                                child: Image.asset('assets/cert4.png')
                            ),
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cert4(name: name.text,rank: rank.text,project: project.text,)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details'),
        actions: <Widget>[

          IconButton(icon: Icon(Icons.done),
            onPressed: (){
              showPreviewDialog();
            },)
        ],),
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
                maxLength: 3,
                controller: rank,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(hintText: 'Rank'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,),
              TextField(
                maxLength: 35,
                controller: project,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(hintText: 'Project'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}