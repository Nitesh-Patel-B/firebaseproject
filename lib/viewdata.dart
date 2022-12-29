import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/update.dart';
import 'package:flutter/material.dart';

class Viewdata extends StatefulWidget {
  const Viewdata({Key? key}) : super(key: key);

  @override
  State<Viewdata> createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  List Mydata = [];

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return status
        ? Scaffold(
      body: ListView.builder(
        itemCount: Mydata.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: PopupMenuButton(
              onSelected: (value) async {
                if (value == 1) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Update();
                    },
                  ));
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(value: 1, child: Text("Update")),
                  PopupMenuItem(child: Text("Delete"))
                ];
              },
            ),
            leading: Image.network("${Mydata[index]['imageurl']}"),
            title: Text("${Mydata[index]['name']}"),
            subtitle: Text("${Mydata[index]['age']}"),
          );
        },
      ),
    )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void initState() {
    super.initState();
    forviewdata();
  }

  forviewdata() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("My Realtime Data");
    DatabaseEvent de = await ref.once();

    Map map = de.snapshot.value as Map;

    map.forEach((key, value) {
      setState(() {
        Mydata.add(value);
        status = true;
      });
    });

    print(de.snapshot.value);
  }
}
