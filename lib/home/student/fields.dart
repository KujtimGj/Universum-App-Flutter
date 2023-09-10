import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uni/home/fieldDetail.dart';
import 'package:uni/model/fieldModel.dart';

class Fields extends StatefulWidget {
  const Fields({Key? key}) : super(key: key);

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {

  List<Field> fieldItems = [];
  Future<void> getFields() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:6000/field"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body)['fields'];
        List<Field> fields =
        responseBody.map<Field>((json) => Field.fromJson(json)).toList();
        setState(() {
          fieldItems = fields;
        });
      } else {
        // Handle non-200 status code
        print('Received status code: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    getFields();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Image.asset("assets/uni.png", height: 70),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView(
        children: [
          SizedBox(height: size.height * 0.05),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Drejtimet",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(
            width: size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: fieldItems.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FieldDetails(
                              singleField: fieldItems[index],
                            )));
                  },
                  child: Container(
                    width: size.width * 0.95,
                    height: size.height * 0.1,
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: const AssetImage("assets/field.jpeg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken),
                        )),
                    child: Center(
                        child: Text(
                          fieldItems[index].field.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
