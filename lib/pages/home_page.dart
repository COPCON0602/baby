import 'package:baby/widget/bottom_navigationbar_icons.dart';

import 'package:baby/pages/bodyPages/growth/growth_infor_list.dart';
import 'package:baby/pages/bodyPages/handbook/hand_book_page.dart';
import 'package:baby/pages/bodyPages/user/user_page.dart';
import 'package:flutter/material.dart';

//import 'bodyPages/user/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bottomNavigationBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(MyFlutterApp.book_reader),
      activeIcon: Icon(MyFlutterApp.book_reader),
      label: 'Cẩm nang',
    ),
    const BottomNavigationBarItem(
      icon: Icon(MyFlutterApp.chart_line),
      activeIcon: Icon(MyFlutterApp.chart_line),
      label: 'Phát triển',
    ),
    const BottomNavigationBarItem(
      icon: Icon(MyFlutterApp.user),
      activeIcon: Icon(MyFlutterApp.user),
      label: 'Cá nhân',
    ),
  ];
  int currentPageIndex = 0;
  final bodyPages = [
    const HandBookPage(),
    const GrowthInforListPage(),
    const UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyPages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarItems,
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        elevation: 100,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
