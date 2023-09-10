import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../const.dart';
import 'base.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({Key? key}) : super(key: key);

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TextEditingController actName = TextEditingController();
  TextEditingController actDate = TextEditingController();
  TextEditingController actType = TextEditingController();
  TextEditingController actField = TextEditingController();

  addActivity(String actName, actDate, actType, actField) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    try {
      final response = await http.post(
        Uri.parse("http://localhost:6000/activity/create"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "actName": actName,
          "actDate": actDate,
          "actType": actType,
          "actField": actField, // Include generation
        }),
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var resBody = jsonDecode(response.body);
          log('$response request successfully sent');
          log("$resBody sdaddasds");
        } else {
          log('Response body is empty.');
        }
        Navigator.push(context, MaterialPageRoute(builder: (_) => Base()));
      } else if (response.statusCode == 400) {
        print(response.statusCode);
        print(response.body);
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Hero(
            tag: 'appBar', child: Image.asset("assets/uni.png", height: 70)),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Shto aktivitet",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
              child: TextFormField(
                controller: actName,
                cursorColor: Colors.black26,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!)),
                    hintText: "Activity name",
                    hintStyle: const TextStyle(color: Colors.black87),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!))),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
              child: TextFormField(
                controller: actType,
                cursorColor: Colors.black26,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!)),
                    hintText: "Activity Type",
                    hintStyle: const TextStyle(color: Colors.black87),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!))),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
              child: TextFormField(
                controller: actDate,
                cursorColor: Colors.black26,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!)),
                    hintText: "Activity Date",
                    hintStyle: const TextStyle(color: Colors.black87),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!))),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
              child: TextFormField(
                controller: actField,
                cursorColor: Colors.black26,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!)),
                    hintText: "Activity Field",
                    hintStyle: const TextStyle(color: Colors.black87),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]!))),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            GestureDetector(
              onTap: () {
                print("Register activity");
                addActivity(
                    actName.text, actDate.text, actType.text, actField.text);
              },
              child: Container(
                height: size.height * 0.07,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor),
                margin: const EdgeInsets.all(10),
                child: const Center(
                  child: Text(
                    'Shto aktivitet',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
