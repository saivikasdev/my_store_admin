import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class Detailsscreen extends StatefulWidget {
  Detailsscreen({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.desc,
  }) : super(key: key);

  final String name;
  final String price;
  final List<dynamic> image;
  final String desc;

  @override
  State<Detailsscreen> createState() => _DetailsscreenState();
}

class _DetailsscreenState extends State<Detailsscreen> {
  File? file;

  TextEditingController productname = TextEditingController();

  TextEditingController productprice = TextEditingController();

  TextEditingController productdesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filename = file != null ? file!.path : 'No file selected';
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
            hintText: '${widget.name}',
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
            hintText: "${widget.price}",
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
            hintText: "${widget.desc}",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        ElevatedButton(
            onPressed: () => changedetails(
                productname.text, productprice.text, productdesc.text),
            // changename(
            //     productname.text,  productdesc.text),
            child: Text("Edit products")),
        ElevatedButton(
            onPressed: () => select_image(),
            // changename(
            //     productname.text,  productdesc.text),
            child: Text("select image")),
        Text(
          '$filename',
        ),
        ElevatedButton(
            onPressed: () => upload_image(widget.name),
            // changename(
            //     productname.text,  productdesc.text),
            child: Text("upload image")),
      ],
    ));
  }

  Future<dynamic> changedetails(String name, String price, String desc) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('products');

    try {
      await users.doc(name).update({
        'name': name,
        'price': price,
        'desc': desc,
      });
      return null;
    } on FirebaseException catch (e) {
      print('error is ...........$e');
    }
  }

  select_image() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return null;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  upload_image(name) async {
    CollectionReference<Map<String, dynamic>> products =
        FirebaseFirestore.instance.collection('products');
    if (file == null) return null;
    final fileName = file!.path;
    final destination = '$fileName';
    final ref = await FirebaseStorage.instance.ref('$fileName');
    await ref.putFile(file!);
    final urlDownload = await ref.getDownloadURL();
    print("image link is here.............$urlDownload");
    products.doc(name).update({
      "images": FieldValue.arrayUnion([urlDownload])
    });
  }
}
