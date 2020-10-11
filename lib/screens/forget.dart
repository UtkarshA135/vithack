import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool loading = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
        backgroundColor: Colors.white,
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
                   color: Colors.grey[100],
                   borderRadius: BorderRadius.circular(10.0),
                 ),

                 child: Form(
                   key: _formKey,
                   child :Column(
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
                     MaterialButton(onPressed: ()async {
                        if(_formKey.currentState.validate())
                    { setState(() {
                      loading =true;
                    });
                      //  dynamic result =
                        await _auth.sendPasswordResetEmail(email: _emailController.text);
                        // _warning = "A password reset link has been sent to $_email";
                      setState((){
                        
                        Navigator.pop(context);

                      });}},
                    minWidth: MediaQuery.of(context).size.width,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     color: Colors.deepPurple[200],
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


          )],
        ),
              ),
      ),

    );
  }
}