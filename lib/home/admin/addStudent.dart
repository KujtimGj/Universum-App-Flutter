import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uni/const.dart';
import 'package:uni/home/admin/base.dart';
import 'package:uni/home/admin/home.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController studentID = TextEditingController();
  final TextEditingController studentField = TextEditingController();
  final TextEditingController generation = TextEditingController();
  bool isObscure = true;



  registerStudent(String fullName,email,password,studentID, studentField, generation)async{
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);

    try{
      final response = await http.post(Uri.parse("http://localhost:6000/user/signup/student"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "fullName": fullName,
          "email": email,
          "password": password,
          "role": 3,
          "studentID": studentID, // Include studentID
          "studentField": studentField, // Include studentField
          "generation": generation, // Include generation
        }),
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var resBody = jsonDecode(response.body);
          log('$response request successfully sent');
        } else {
          log('Response body is empty.');
        }

        final smtpServer = gmailSaslXoauth2('gjokajkujtim9@gmail.com', 'PredatorSense1!');
        final message = Message()
          ..from = Address('gjokajkujtim9@gmail.com', 'Kujtim Gjokaj')
          ..recipients.add("gjokajkujtim9@gmail.com")
          ..subject = 'Dear $fullName your email has been created'
          ..text = "Dear $fullName,We're excited to inform you that your account has been successfully created for [Your App Name]. Please keep the following credentials handy:Email: $email Password: $password"
          ..html = '<p>This is a test email sent from <b>Flutter</b> using the <i>mailer</i> package.</p>';

        final sendReport = await send(message, smtpServer);
        print(sendReport);

        Navigator.push(context, MaterialPageRoute(builder: (_)=>Base()));
      }else if(response.statusCode==400){
        print(response.statusCode);
        print(response.body);
      }

    }catch(error){
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
        title: Image.asset("assets/uni.png", height: 70),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const  Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Add a new student",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: size.height*0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                child: TextFormField(
                  controller: fullName,
                  cursorColor: Colors.black26,
                  style: const TextStyle(color: Colors.black),
                  obscureText: false,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      hintText: "Full Name",
                      hintStyle: const TextStyle(color: Colors.black87),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!))),
                ),
              ),
              SizedBox(height: size.height*0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                child: TextFormField(
                  controller: email,
                  cursorColor: Colors.black26,
                  style: const TextStyle(color: Colors.black),
                  obscureText: false,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.black87),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!))),
                ),
              ),
              SizedBox(height: size.height*0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                child: TextFormField(
                  controller: password,
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
              SizedBox(height: size.height*0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                child: TextFormField(
                  controller: studentID,
                  cursorColor: Colors.black26,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      hintText: "Student ID",
                      hintStyle: const TextStyle(color: Colors.black87),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!))),
                ),
              ),
              SizedBox(height: size.height*0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                child: TextFormField(
                  controller: studentField,
                  cursorColor: Colors.black26,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      hintText: "Student Field",
                      hintStyle: const TextStyle(color: Colors.black87),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!))),
                ),
              ),
              SizedBox(height: size.height*0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                child: TextFormField(
                  controller: generation,
                  cursorColor: Colors.black26,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!)),
                      hintText: "Generation",
                      hintStyle: const TextStyle(color: Colors.black87),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!))),
                ),
              ),
              SizedBox(height: size.height*0.03),
              GestureDetector(
                onTap: (){
                  print("Register student");
                  registerStudent(fullName.text, email.text, password.text,studentID.text,studentField.text,generation.text);
                },
                child: Container(
                  height: size.height*0.07,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor
                  ),
                  margin: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text('Register student',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
