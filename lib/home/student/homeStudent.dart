import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uni/home/actDetail.dart';
import 'package:uni/home/fieldDetail.dart';
import 'package:uni/model/activityModel.dart';
import 'package:uni/model/fairModel.dart';
import 'package:uni/model/fieldModel.dart';
import 'package:http/http.dart' as http;

import '../fairDetail.dart';

class HomeStudent extends StatefulWidget {
  const HomeStudent({Key? key}) : super(key: key);

  @override
  State<HomeStudent> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {


  List<Activity> itemList = [];


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



  @override
  void initState() {
    getActivity();
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
            width: size.width,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
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

        ],
      ),
    );
  }
}
