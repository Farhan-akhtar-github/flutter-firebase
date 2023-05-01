import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class read_data extends StatefulWidget {
  const read_data({super.key});

  @override
  State<read_data> createState() => _read_dataState();
}

class _read_dataState extends State<read_data> {
  getdata() async {
    var result = await FirebaseFirestore.instance.collection("farhan").get();
    return result;
  }

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
                return Text("${snapshot.data.docs[index]['name']}");
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
