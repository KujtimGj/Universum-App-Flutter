import 'package:flutter/material.dart';
import 'package:uni/home/account.dart';
import 'package:uni/home/student/fairs.dart';
import 'package:uni/home/student/fields.dart';
import 'package:uni/home/student/homeStudent.dart';

class BaseStudent extends StatefulWidget {
  const BaseStudent({Key? key}) : super(key: key);

  @override
  State<BaseStudent> createState() => _BaseStudentState();
}

class _BaseStudentState extends State<BaseStudent> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeStudent(),
    const Fields(),
    const Fairs(),
    const Account(),

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 0
                      ? Icons.home_rounded
                      : Icons.home_outlined,
                  size: 30,
                  color: Colors.black87,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 1 ? Icons.menu_book_sharp : Icons.menu_book_outlined,
                  size: 30,
                  color: Colors.black87,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 2 ? Icons.local_activity : Icons.local_activity_outlined,
                  size: 30,
                  color: Colors.black87,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 3
                      ? Icons.account_circle
                      : Icons.account_circle_outlined,
                  size: 30,
                  color: Colors.black87,
                ),
                label: ""),
          ],
        ),
      ),
    );
  }
}
