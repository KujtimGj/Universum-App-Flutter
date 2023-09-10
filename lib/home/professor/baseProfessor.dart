import 'package:flutter/material.dart';
import 'package:uni/home/account.dart';
import 'package:uni/home/professor/homeProfessor.dart';
import 'package:uni/home/professor/studentsList.dart';

class BaseProfessor extends StatefulWidget {
  const BaseProfessor({Key? key}) : super(key: key);

  @override
  State<BaseProfessor> createState() => _BaseProfessorState();
}

class _BaseProfessorState extends State<BaseProfessor> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeProfessor(),
    const StudentsList(),
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
                  _selectedIndex == 1 ? Icons.search : Icons.search,
                  size: 30,
                  color: Colors.black87,
                ),
                label: ""),

            BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 2
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
