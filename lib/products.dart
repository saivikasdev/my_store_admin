import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'detailsscreen.dart';

class productscreen extends StatelessWidget {
  productscreen({
    Key? key,
  }) : super(key: key);
  CollectionReference<Map<String, dynamic>> offersofweek =
      FirebaseFirestore.instance.collection('products');

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 870,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                                  child: InkWell(
                                    onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Detailsscreen(image: data['images'],
                                      name: data['name'],
                                      price: data['price'],
                                      desc: data['desc'],
                                      status: data['status'],))),
                                    child: SpecialOfferCard(
                                      image: data['images'],
                                      name: data['name'],
                                      price: data['price'],
                                      desc: data['desc'],
                                      status: data['status'],
                                    ),
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
                width: 50,
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
    required this.name,
    required this.image,
    required this.price,
    required this.desc,
    required this.status,
  }) : super(key: key);

  final String name;
  final int price;
  final List<dynamic> image;
  final String desc;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 50),
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
                  Image.network(
                    image[0],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF343434).withOpacity(0.4),
                          Color(0xFF343434).withOpacity(0.15),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical:50,
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        children: [
                          TextSpan(
                            text: "$name\n",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(text: "$price/-"),
                          TextSpan(
                              text: "$status",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
