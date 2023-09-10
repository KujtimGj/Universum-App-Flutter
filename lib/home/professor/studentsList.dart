import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uni/const.dart';
import 'package:uni/model/studentModel.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({Key? key}) : super(key: key);

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {




  List<Student> studentsList = [];

  getStudents() async {
    try {
      var response = await http.get(Uri.parse("http://localhost:6000/user/allStuds"),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print(response.body);
        var resBody = jsonDecode(response.body)['students'];
        // Check if resBody is not null before mapping
        if (resBody != null) {
          var students =
              resBody.map<Student>((json) => Student.fromJson(json)).toList();

          setState(() {
            studentsList = students;
          });
          print(studentsList);
        } else {
          print('Response body is null.');
        }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    getStudents();
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
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Students List",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
          ),
          SizedBox(
            width: size.width,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: studentsList.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  margin: const EdgeInsets.all(15),
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: primaryColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.account_circle,size: 50),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:size.width*0.15,
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        const Text("Emri:"),
                                        Text(studentsList[index].fullName,style:const TextStyle(fontSize: 18),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      const Text("Email:"),
                                      Text(studentsList[index].email.toString(),style:const TextStyle(fontSize: 18)),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: size.height*0.03),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      const Text("Drejtimi:"),
                                      Text(studentsList[index].studentField,style:const TextStyle(fontSize: 18),),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      const Text("Gjenerata:"),
                                      Text(studentsList[index].generation.toString(),style:const TextStyle(fontSize: 18)),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: size.height*0.03),

                            ],
                          ),
                        ),
                      ],
                    )
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
