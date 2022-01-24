import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Malvinas/firebase_options.dart';

class GetUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(data());
    return Container(
      child: Text('da'),
    );
  }

  FutureBuilder<DocumentSnapshot> data() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String d;
    FutureBuilder<DocumentSnapshot>(
      future: users.doc().get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          d = "Something went wrong";
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          d = "Document does not exist";
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          d = "Full Name: ${data['nombre']} ${data['edad']}";
        }

        return Text("loading");
      },
    );
    print(d);
  }
}
