import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            
       
          Center(
            child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                 height: 0.5*MediaQuery.of(context).size.height,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10.0),
                 ),
                
                 child: Column(
                   children: <Widget>[
                     Center(
              child: Text("Register",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
              ),
              
            ),
                 SizedBox(height: 20.0,),
                     TextFormField(
                       decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,
                        color: Colors.black,
                        ),
                         hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                       ),
                     ),
                     SizedBox(height: 10.0,),
                     TextFormField(
                       decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email,
                        color: Colors.black,
                        ),
                         hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                       ),
                     ),
                     SizedBox(height: 10.0,),
                     TextFormField(
                       decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,
                        color: Colors.black,
                        ),
                         hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                       ),
                     ),
                     SizedBox(height: 30.0,),
                     MaterialButton(onPressed: (){},
                    minWidth: MediaQuery.of(context).size.width,
                     color: Colors.amber,
                    height: MediaQuery.of(context).size.height/12,
                    child: Text("Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      //fontWeight: FontWeight.bold,
                    ),
                    ),
                     )
                   ],
                 ),
            ),
          ),
              
          
          ],
        ),
              ),
      ),
    );
  }
}
