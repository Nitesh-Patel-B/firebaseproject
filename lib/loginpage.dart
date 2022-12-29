
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/main.dart';
import 'package:firebaseproject/signup.dart';
import 'package:firebaseproject/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Mainpage();
                  },
                ));
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Center(child: Text("User Login")),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("email"),
                      hintText: "Enter Your Email"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
                      hintText: "Enter Your Password"),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text, password: password.text).then((value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return Dashboard();
                            },));
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Login success"),
                        duration: Duration(seconds: 2),
                      ));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("New user please Signup")));
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Wrong password")));
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  child: Text("Login")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New user>>>"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Signup();
                          },
                        ));
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
