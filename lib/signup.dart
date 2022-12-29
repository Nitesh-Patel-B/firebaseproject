import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/loginpage.dart';
import 'package:firebaseproject/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
          title: Center(
            child: Text("SignUp"),
          ),
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
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Success")));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Password is too Weak")));
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("email already exist please SignIn")));
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                    print("New user");
                  },
                  child: Text("Signup")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Return to"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
