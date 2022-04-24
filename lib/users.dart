import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
class usersscreen extends StatelessWidget {
  usersscreen({
    Key? key,
  }) : super(key: key);
  CollectionReference<Map<String, dynamic>> offersofweek =
      FirebaseFirestore.instance.collection('products');

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
            height: 870,
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              SizedBox(height: 20),
              Container(
                height: 900,
                child: SafeArea(
                  child: SizedBox(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print(
                                '////////////////////////////////////////////////////////////////////////////////////////');
                          }
            
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.deepOrangeAccent,
                              ),
                            );
                          } else {
                            Center(child: CircularProgressIndicator());
                          }
            
                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children:
                                snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return SizedBox(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SpecialOfferCard(
                                    email: data['EMAIL'],
                                    password: data['PASSWORD'],
                                    uid: data['UID'],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}










class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.email,
    required this.password,
    required this.uid,
  }) : super(key: key);

  final String email;
  final String password;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(255, 121, 213, 255),),
          height: 70,
          width: 400,
          child: Row(
            children: [
              SizedBox(width: 40,),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Color.fromARGB(31, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                  children: [
                    TextSpan(
                      text: "$email\n",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    TextSpan(text: "$password             "
                    ,style: TextStyle(color: Color.fromARGB(115, 46, 48, 45), fontSize: 19)
                    ),
                    TextSpan(
                        text: "$uid",
                        style: TextStyle(color: Color.fromARGB(115, 242, 2, 2), fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}
