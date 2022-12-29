import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/loginpage.dart';
import 'package:firebaseproject/signup.dart';
import 'package:firebaseproject/user.dart';
import 'package:firebaseproject/viewdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Mainpage(),
  ));
}

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusbar = MediaQuery.of(context).padding.top;
    double navbar = MediaQuery.of(context).padding.bottom;
    double appbar = kToolbarHeight;
    double bodyheight = height - statusbar - navbar - appbar;
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Center(child: Text("Firebase App")),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(1),
            child: SizedBox(child: Image.asset("Image/login.png")),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ));
                    },
                    child: Text("Login")),
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Signup();
                        },
                      ));
                    },
                    child: Text("SignUp")),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(onPressed: () {}, child: Text("Email")),
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(onPressed: () {}, child: Text("Mobile")),
              )
            ],
          )
        ],
      ),
    );

    // : Center(
    //     child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       CircularProgressIndicator(
    //         color: Colors.lightGreen,
    //       ),
    //       SizedBox(
    //         height: 50,
    //       ),
    //       Text(
    //         "Loading...",
    //         style: TextStyle(fontSize: 30),
    //       )
    //     ],
    //   ));
  }
}
