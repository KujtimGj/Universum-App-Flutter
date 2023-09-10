import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni/auth/login.dart';
import 'package:uni/home/admin/base.dart';
import 'package:uni/home/professor/baseProfessor.dart';
import 'package:uni/home/student/baseStudent.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized.
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var isLoggedin = localStorage.getBool("isLoggedIn") ?? false; // Use
  var role = localStorage.getInt("role")??0;
  runApp( MyApp(isLoggedIn: isLoggedin,role: role,));
}
class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final int role;
  const MyApp({Key? key, required this.isLoggedIn, required this.role}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget getHomePage() {
    print("Role: ${widget.role}");
    if (widget.isLoggedIn) {
      if (widget.role == 1) {
        print("Redirecting to Base");
        return const Base(); // Use const constructor
      } else if (widget.role == 2) {
        print("Redirecting to BaseProfessor");
        return const BaseProfessor(); // Use const constructor
      } else if (widget.role == 3) {
        print("Redirecting to BaseStudent");
        return const BaseStudent(); // Use const constructor
      } else {
        print("Redirecting to Login (Role not recognized)");
        return const Login(); // Use const constructor
      }
    } else {
      print("Redirecting to Login (Not Logged In)");
      return const Login(); // Use const constructor
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: getHomePage(),
    );
  }
}
