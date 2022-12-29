import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseproject/viewdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime date = DateTime.now();

  String img = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  // image picker
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final XFile? image = await _picker.pickImage(
                        imageQuality: 20, source: ImageSource.gallery);
                    setState(() {
                      img = image!.path;
                    });
                    // Capture a photo
                  },
                  child: Container(
                    height: 100,
                    width: 150,
                    child: CircleAvatar(
                      radius: 200,
                      backgroundImage: FileImage(File(img)),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    controller: uname,
                    decoration: InputDecoration(hintText: "Enter name"),
                  )),
              Container(
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    controller: age,
                    decoration: InputDecoration(hintText: "Enter age"),
                  )),
              Container(
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    controller: number,
                    decoration: InputDecoration(hintText: "Enter number"),
                  )),
              // ElevatedButton(
              //     onPressed: () async {
              //       final storageRef = FirebaseStorage.instance.ref();
              //       String dt =
              //           "${date.day}-${date.month}-${date.year}-${date.hour}:${date.minute}";
              //       String imagename =
              //           "MyImages${Random().nextInt(1000)}${dt}.jpg";
              //
              //       final spaceRef = storageRef.child("Nitesh/$imagename");
              //       await spaceRef.putFile(File(img));
              //       spaceRef.getDownloadURL().then((value) async {
              //         print("${value}");
              //
              //         print("folder");
              //         setState(() {
              //           imageurl = value;
              //         });
              //         print("image");
              //
              //
              //         print("realtime");
              //         // Navigator.pushReplacement(context, MaterialPageRoute(
              //         //   builder: (context) {
              //         //     return Viewdata();
              //         //   },
              //         // ));
              //       });
              //     },
              //     child: Text("Send Data")),

              ElevatedButton(onPressed: () async {


                DatabaseReference ref = FirebaseDatabase.instance
                    .ref("MyRealTimedata")
                    .push();

                String? id = ref.key;
                await ref.set({
                  "name": uname.text,
                  "age": age.text,
                  "number": number.text,
                  "image":imageurl,
                  "id": id,

                });
                print("obj${uname}");
              },
                  child: Text("Send realtime"))
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController uname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController number = TextEditingController();
  String imageurl = "";
}
