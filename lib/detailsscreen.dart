import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detailsscreen extends StatelessWidget {
  Detailsscreen({
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

  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 100,
        ),
        TextFormField(
          controller: productname,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "product name",
            hintText: '$name',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 0,
        ),
        TextFormField(
          controller: productprice,
          
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "price",
            hintText: "$price",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 0,
        ),
        TextFormField(
          controller: productdesc,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "description",
            hintText: "$desc",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        
        ElevatedButton(
            onPressed: () => changedetails(productname.text,productprice.text.hashCode, productdesc.text),
            // changename(
            //     productname.text,  productdesc.text),
            child: Text("Edit products")),
      ],
    ));
  }

  Future<dynamic> changedetails(String name, int price, String desc) async {
    final snackBar = SnackBar(
        content: Text(
      'Something went wrong',
      style: TextStyle(
        color: Colors.deepOrangeAccent,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ));
    final sucBar = SnackBar(
        content: Text(
      'User may be created you may login (or) try with some other gmail',
      style: TextStyle(
        color: Colors.deepOrangeAccent,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ));

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('products');

    try {
      await users.doc('YOBtVCzUbsYTyEViTHj3').update({
        'name': name,
        'price': price,
        'desc': desc,
      });
      return null;
    } on FirebaseException catch (e) {
      print('error is ...........$e');
    }
  }
}
