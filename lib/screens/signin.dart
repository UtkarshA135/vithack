import 'package:certificate_generator/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _success;

  String _userEmail;

    void _signInWithEmailAndPassword() async {
      print(_emailController.text);

  final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  )).user;
  
  if (user != null) {
    setState(() {
      _success = true;
      _userEmail = user.email;
    });
    await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
  } else {
    setState(() {
      _success = false;
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
          child:  Form(
      key: _formKey,
      child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  height: 0.45 * MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
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
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          hintText: "Password",
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
                        color: Colors.amber,
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
                onPressed: () {},
                minWidth: MediaQuery.of(context).size.width,
                color: Colors.black,
                height: MediaQuery.of(context).size.height / 18,
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              MaterialButton(
                onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Register()),
  );},
                minWidth: MediaQuery.of(context).size.width,
                color: Colors.black,
                height: MediaQuery.of(context).size.height / 18,
                child: Text(
                  "Don't have a account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

       @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}














































 