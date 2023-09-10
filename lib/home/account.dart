import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {


  String name = '';
  String email = '';
  int? role;
  String roleName ='';
  String field = '';
  String generation='';
  String workerIdAdmin='';
  String workerIdProfa='';
  String subject='';
  getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('fullName').toString();
      email = localStorage.getString("email").toString();
      role = localStorage.getInt('role');
      if(role==1){
        workerIdAdmin= localStorage.getString('workerIdAdmin').toString();
      }else if (role==2){
        workerIdProfa = localStorage.getString('workerIdProfa').toString();
        subject = localStorage.getString('subject').toString();
        print("Subjekti $subject");
      }else if(role==3){
        field = localStorage.getString('field').toString();
        generation = localStorage.getString('generation').toString();
      }
    });
    log(role.toString());
    if(role==1){
      setState(() {
        roleName='Admin';
      });
    }else if(role==2){
      setState(() {
        roleName='Professor';
      });
    }else if(role==3){
      setState(() {
        roleName='Student';
      });
    }
  }
  logout(context)async{
    SharedPreferences localStorage = await  SharedPreferences.getInstance();
    localStorage.remove("isLoggedIn");
    localStorage.remove('fullName');
    localStorage.remove('role');
    log("Logged out");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const Login()), (route) => false);
  }


  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.1),
                Center(child: Icon(Icons.account_circle,size:size.height*0.2)),
                Center(child: Text(name,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),)),
                Column(
                  children: [
                    SizedBox(height: size.height*0.05),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email",style: TextStyle(color: Colors.grey[800]),),
                          Text(email,style: const TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Roli",style: TextStyle(color: Colors.grey[800]),),
                          Text(roleName,style: const TextStyle(fontSize: 18,color: Colors.black),)
                        ],
                      ),
                    ),
                    if(role==3)
                        StudentDetails(field: field, generation: generation)
                    else if(role==2)
                        ProfessorDetails(workerIdProfa: workerIdProfa, subject: subject)

                  ],
                ),
                SizedBox(
                  height: size.height*0.3,
                  child:  Center(
                      child: GestureDetector(
                          onTap: () {
                            logout(context);
                          },
                          child: const Text(
                            "Log out",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentDetails extends StatelessWidget {
  const StudentDetails({
    super.key,
    required this.field,
    required this.generation,
  });

  final String field;
  final String generation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Drejtimi",style: TextStyle(color: Colors.grey[800]),),
              Text(field,style: const TextStyle(fontSize: 18,color: Colors.black),)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Gjenerata",style: TextStyle(color: Colors.grey[800]),),
              Text(generation,style: const TextStyle(fontSize: 18,color: Colors.black),)
            ],
          ),
        ),
      ],
    );
  }
}
class ProfessorDetails extends StatelessWidget {
  const ProfessorDetails({
    super.key,
    required this.workerIdProfa,
    required this.subject,
  });

  final String workerIdProfa;
  final String subject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Worker ID",style: TextStyle(color: Colors.grey[800]),),
              Text(workerIdProfa,style: const TextStyle(fontSize: 18,color: Colors.black),)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Lënda",style: TextStyle(color: Colors.grey[800]),),
              Text(subject,style: const TextStyle(fontSize: 18,color: Colors.black),)
            ],
          ),
        ),
      ],
    );
  }
}
