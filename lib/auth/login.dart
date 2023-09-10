import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uni/home/admin/base.dart';
import 'package:uni/const.dart';
import 'package:uni/home/professor/baseProfessor.dart';
import 'package:uni/home/student/baseStudent.dart';

import '../home/admin/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();


  Future login() async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:6000/user/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _email.text,
          'password': _password.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final res = responseBody['user'];
        final user = responseBody['userType'];
        final token = responseBody['token'];
        final role = responseBody['user']['role'];

        print(res);
        print(user);
        print(token);
        print(role);

        // Store token and user information in SharedPreferences or elsewhere for future use
        final localStorage = await SharedPreferences.getInstance();
        localStorage.setString("token", token);
        localStorage.setBool("isLoggedIn", true);
        localStorage.setString("fullName", res['fullName']);
        localStorage.setString('email', res['email']);
        localStorage.setInt("role", res['role']);


        if(role ==1){
          localStorage.setString("workerIdAdmin", user['workerId']);
          Navigator.push(context, MaterialPageRoute(builder: (_) => Base()));
        }else if(role==2){
          localStorage.setString("workerIdProfa", user['workerId']);
          localStorage.setString("subject", user['subject']);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => BaseProfessor()));
        }else if(role==3){
          localStorage.setString("studentID", user['studentID']);
          localStorage.setString("field", user['studentField']);
          localStorage.setString("generation", user['generation']);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => BaseStudent()));
        }

      } else {
        // Handle unsuccessful login, e.g., display an error message
        print("Login failed. Status code: ${response.statusCode}");
        // You can also handle specific error messages from the server if available in the response.
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['error'];
        print("Error message: $errorMessage");
      }
    } catch (e) {
      // Handle network or other errors
      print("Network Error: $e");
      // Display an error message to the user
    }
  }


  getFromStudents()async{

  }

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: size.width*0.01),
            child: Column(
              children: [
                const Text(
                  "Log in",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size.height*0.01,
                ),
                Container(
                  height: 3,
                  width: size.width*0.17,
                  color: Colors.black87,
                )
              ],
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
            child: const Text("Universum App",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),),
          ),
          Center(child: Image.asset("assets/uni.png",height: size.height*0.2,)),
          SizedBox(height: size.height*0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: TextFormField(
              controller: _email,
              cursorColor: Colors.black26,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[500]!)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[500]!)),
                  hintText: " Email",
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[500]!))),
            ),
          ),
          SizedBox(height: size.height * 0.07),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
            child: TextFormField(
              controller: _password,
              cursorColor: Colors.black26,
              style: const TextStyle(color: Colors.black),
              obscureText: isObscure,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: isObscure == true
                          ? const Icon(
                        Icons.visibility,
                        color: Colors.black54,
                      )
                          : const Icon(
                        Icons.visibility_off,
                        color: Colors.black54,
                      )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[500]!)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[500]!)),
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.black87),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[500]!))),
            ),
          ),

          SizedBox(height: size.height * 0.06),
          GestureDetector(
              onTap: () {
                login();
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                    height: size.height * 0.075,
                    width: size.width*0.3,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: const Center(
                        child: Icon(Icons.arrow_forward,size: 30,color: Colors.white,)
                    )),
              ))
        ],
      ),
    );
  }
}
