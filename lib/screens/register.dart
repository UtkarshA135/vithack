import 'package:certificate_generator/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  final String title = 'Registration';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _success;
String _userEmail;
final FirebaseAuth _auth = FirebaseAuth.instance;

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}
void _register() async {
  final FirebaseUser user = (await 
      _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
  ).user;
  if (user != null) {
    setState(() {
      _success = true;
      _userEmail = user.email;
    });
   await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  );
  } else {
    setState(() {
      _success = true;
    });
  }
}
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
                
                 child:Form(
                   key: _formKey,
                   child: 
                  Column(
                   children: <Widget>[
                     Center(
              child: Text("Register with us !!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              ),
              
            ),
                 SizedBox(height: 20.0,),
                   
                    
                     TextFormField(
                       controller: _emailController,
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
                     TextFormField(
                       controller: _passwordController,
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
                     MaterialButton(onPressed: (){
                          if (_formKey.currentState.validate()) {
                  _register();
                     }},
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
              
          
          )],
        ),
              ),
      ),
    );
  }
}