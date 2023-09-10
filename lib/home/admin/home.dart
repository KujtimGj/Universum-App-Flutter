import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uni/home/actDetail.dart';
import 'package:uni/home/fairDetail.dart';
import 'package:uni/home/fieldDetail.dart';
import 'package:uni/model/activityModel.dart';
import 'package:uni/model/fairModel.dart';
import 'package:uni/model/fieldModel.dart';
import 'package:uni/model/userModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Activity> itemList = [];
  List<Field> fieldItems = [];
  List<Fair> fairItems = [];

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

  getActivity() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:6000/activity"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        // print(resBody);

        // Check if resBody is not null before mapping
        if (resBody != null) {
          var actList =
              resBody.map<Activity>((json) => Activity.fromJson(json)).toList();

          setState(() {
            itemList = actList; // Populate itemList with response data
          });
          print(itemList.toString());
        } else {
          // Handle the case where resBody is null
          print('Response body is null.');
        }
      } else {
        // Handle non-200 status code
        print('Received status code: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

  getFairs() async {
    try {
      final response = await http.get(Uri.parse("http://localhost:6000/panair"),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body)['panaire'];
        List<Fair> fairs =
            responseBody.map<Fair>((json) => Fair.fromJson(json)).toList();
        setState(() {
          fairItems = fairs;
        });
        print("==============");
      } else if (response.statusCode == 400) {
        print(response.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    getFields();
    getActivity();
    getFairs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Image.asset("assets/uni.png", height: 70),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          SizedBox(height: size.height * 0.05),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Aktivitetet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(
            height: size.height * 0.25,
            width: size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ActDetail(
                                  singleActivity: itemList[index],
                                )));
                  },
                  child: Container(
                    width: size.width * 0.95,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: const AssetImage("assets/activity.jpg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemList[index].actDate,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            itemList[index].actName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            itemList[index].actType,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            itemList[index].actField,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: size.height * 0.01),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Drejtimet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(
            height: size.height * 0.1,
            width: size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
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
                    margin: const EdgeInsets.symmetric(horizontal: 10),
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
          SizedBox(height: size.height * 0.01),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Panairet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(
            width: size.width,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: fairItems.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                FairDetail(signleFair: fairItems[index])));
                  },
                  child: Container(
                    width: size.width * 0.95,
                    height: size.height * 0.25,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: const AssetImage("assets/panaire.jpeg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.darken),
                        )),
                    child: Center(
                      child: Text(
                        fairItems[index].title.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
