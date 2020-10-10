import 'package:flutter/material.dart';

class Forgot extends StatelessWidget {
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
                     Icon(Icons.lock,
                     color: Colors.black,
                     size: 50.0,
                     ),
                     SizedBox(height: 10.0,),
                     Center(
              child: Text("Forgot Password?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 34.0,
                fontWeight: FontWeight.bold,
              ),
              ),
              
            ),
            SizedBox(height: 10.0,),
            Text("Enter your email address and we'll send a link to reset your password",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              ),
              
                     SizedBox(height: 20.0,),
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
                   
                     SizedBox(height: 30.0,),
                     MaterialButton(onPressed: (){},
                    minWidth: MediaQuery.of(context).size.width,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     color: Colors.amber,
                    height: MediaQuery.of(context).size.height/12,
                    child: Text("Reset",
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