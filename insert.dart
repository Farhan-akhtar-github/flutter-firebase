import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class insertscreen extends StatefulWidget {
  const insertscreen({super.key});

  @override
  State<insertscreen> createState() => _insertscreenState();
}

class _insertscreenState extends State<insertscreen> {
  addata(value) async {
    await FirebaseFirestore.instance.collection("farhan").add({
      'name': value,
    });
  }

  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(onChanged: ((value) {
          name = value;
        })),
        SizedBox(
          height: 40,
        ),
        ElevatedButton(
            onPressed: () {
              addata(name);
            },
            child: Text("add data"))
      ],
    ));
  }
}
