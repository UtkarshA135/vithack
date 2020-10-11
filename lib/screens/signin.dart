import 'package:certificate_generator/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'forget.dart';
//import 'package:global_cert/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final TextEditingController _emailController = TextEditingController();

final TextEditingController _passwordController = TextEditingController();
bool _success;
String _userEmail;
final FirebaseAuth _auth = FirebaseAuth.instance;

void _signInWithEmailAndPassword() async {
  final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  )).user;
  
  if (user != null) {
    setState(() {
      _success = true;
      _userEmail = user.email;
    });
     if (user.isEmailVerified)
       await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()));
    
  } else {
    setState(() {
      _success = false;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),

          
          child: SingleChildScrollView(
                      child: Center(
                        child: 
                        Form(key: _formKey,
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 80.0)),
   Row(
               children: <Widget>[
    Expanded(
          child: Image(
        height: 80.0,
        image: AssetImage("assets/logo2.jpg"),
      
      ),
    ),
  
    
                  Expanded(
                    flex: 2,
                                    child: Text("CERT-MAKER",
                    
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                  ),
  ],
),
         
                SizedBox(height: 30.0,),
               Row(
                   children: <Widget>[
                        Expanded(
                        
                         child: Image(
                          
                      height: 40.0,
                    image: AssetImage("assets/build.jpg",
                    
                    ),
                  //color: Colors.grey,
                  ),
                        ),
                    Icon(Icons.arrow_forward, size: 40.0,),
                        Expanded(
                                                  child: Image(
                      height: 40.0,
                    image: AssetImage("assets/send1.jpg",
                    
                    ),
                  ),
                        ),
                   
                      
                         Icon(Icons.arrow_forward, size: 40.0,),
                         Expanded(
                        
                         child: Image(
                          
                      height: 40.0,
                    image: AssetImage("assets/cloud1.png",
                    
                    ),
                  //color: Colors.grey,
                  ),
                        ),
                   ],
                 ),
                 
              SizedBox(height: 20.0,),
                Center(
                  child: Container(
                    padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    height: 0.45 * MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:
                     Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.white
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            obscureText:true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                            
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Password",
                              
                                fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          MaterialButton(
                            onPressed: () {
                               if (_formKey.currentState.validate()) {
                                 _signInWithEmailAndPassword();
                  }},
                            
                            minWidth: MediaQuery.of(context).size.width,
                            color: Colors.deepPurple[200],
                            height: MediaQuery.of(context).size.height / 12,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Forgot()),
                    );
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  elevation: 0.0,
                  height: MediaQuery.of(context).size.height / 18,
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  elevation: 0.0,
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 18,
                  child: Text(
                    "Don't have a account?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                    ],
            ),
                      ),
          ),
        ),
      ),
    ));
  }
}
