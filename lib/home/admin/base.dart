import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/home/account.dart';
import 'package:uni/home/admin/addActivity.dart';
import 'package:uni/home/admin/addStudent.dart';
import 'package:uni/home/admin/home.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const AddActivity(),
    const AddStudent(),
    const Account()
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
                  _selectedIndex == 1 ? Icons.local_activity : Icons.local_activity_outlined,
                  size: 30,
                  color: Colors.black87,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? SvgPicture.asset(
                  "assets/navIcons/user-graduate.svg",
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.color),
                  height: 25,
                )
                    :SvgPicture.asset("assets/navIcons/student.svg",
                  colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.color),height: 25,),
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
