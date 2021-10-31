import 'package:flutter/material.dart';
import '../screens/flooz.dart';

import '../screens/Tmoney.dart';
//import '../constants.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List _pages = [
    Flooz(),
    Tmoney(),
  ];
  int _selectIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var bottomNav = BottomNavigationBar(
      currentIndex: _selectIndex,
      onTap: _selectPage,
      elevation: 7,
      selectedFontSize: 12,
      // selectedIconTheme: IconThemeData(
      //   color: primaryColor,
      // ),
      // selectedItemColor: iconColor,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: "Flooz",
          //backgroundColor: manColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.money_sharp,
            //color: girlColor,
          ),
          label: "Tmoney",
          //backgroundColor: girlColor,
        ),
      ],
    );
    return Scaffold(
        // drawer: MyDrawer(),
        body: _pages[_selectIndex],
        bottomNavigationBar: bottomNav);
  }
}
