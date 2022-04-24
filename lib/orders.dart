import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class orderscreen extends StatelessWidget {
  orderscreen({
    Key? key,
  }) : super(key: key);
  CollectionReference<Map<String, dynamic>> offersofweek =
      FirebaseFirestore.instance.collection('products');

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          height: 820,
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
                              number: data['phone number'],
                              product_name: data['NAME'],
                              status: data['status'],
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
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.number,
    required this.product_name,
    required this.status,
  }) : super(key: key);

  final String number;
  final String product_name;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(255, 255, 145, 48),),
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
                      text: "$number\n",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    TextSpan(text: "$product_name             "
                    ,style: TextStyle(color: Color.fromARGB(115, 46, 48, 45), fontSize: 19)
                    ),
                    TextSpan(
                        text: "$status",
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
