import 'package:flutter/material.dart';
import 'package:uni/model/fieldModel.dart';

class FieldDetails extends StatefulWidget {
  final Field singleField;
  const FieldDetails({Key? key, required this.singleField}) : super(key: key);

  @override
  State<FieldDetails> createState() => _FieldDetailsState();
}

class _FieldDetailsState extends State<FieldDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Hero(
              tag: 'appBar', child: Image.asset("assets/uni.png", height: 70)),
          backgroundColor: Colors.white,
          // elevation: 4,
        ),
        body: ListView(
          children: [
            Container(
              height: size.height * 0.35,
              width: size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/field.jpeg"),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.singleField.field,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "në Kolegjin Universum",
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    widget.singleField.description,
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey[700], height: 1.5),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}
