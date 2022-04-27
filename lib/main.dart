import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mystore_admin/products.dart';
import 'package:mystore_admin/users.dart';

import 'orders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
            height: 700,
            child: SingleChildScrollView(
                child: Column(
              children: [
                orderscreen(),
              ],
            ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            InkWell(
              onTap:  () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => usersscreen())),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Color.fromARGB(213, 2, 150, 248),
                ),
                height: 60,
                width: 200,
                child: Text(
                  'users',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),

            InkWell(
              onTap:  () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => productscreen())),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Color.fromARGB(213, 2, 150, 248),
                ),
                height: 60,
                width: 200,
                child: Text(
                  'products',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
