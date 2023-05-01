import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  getdata() async {
    var result = await FirebaseFirestore.instance.collection("students").get();
    return result;
  }

  updatedata(id, Value) async {
    await FirebaseFirestore.instance
        .collection("students")
        .doc(id)
        .update({'name': Value});
  }

  deletedata(id) async {
    await FirebaseFirestore.instance.collection("students").doc(id).delete();
  }

  String updatedname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getdata(),
      builder: (context, dynamic snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: GestureDetector(
                        onTap: () {
                          // to use Get first import it in pubsec.yaml file and then it in your main.dart and also in that file you are using
                          Get.defaultDialog(
                              content: TextField(
                                onChanged: (Value) {
                                  setState(() {
                                    updatedname = Value;
                                  });
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      updatedata(snapshot.data.docs[index].id,
                                          updatedname);
                                      setState(() {});
                                    },
                                    child: Text('update name'))
                              ]);
                        },
                        child: Icon(Icons.check_circle)),
                    title: Text("${snapshot.data.docs[index]['name']}"),
                    trailing: GestureDetector(
                      onTap: () {
                        deletedata((snapshot.data.docs[index].id));
                        setState(() {});
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
