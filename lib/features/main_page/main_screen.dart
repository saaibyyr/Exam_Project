import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:medicine_app/features/home_page/homepage.dart';
import 'package:medicine_app/features/profile_page/profile.dart';
import 'package:medicine_app/features/qr_page/qr_screen.dart';
import 'package:medicine_app/features/story_page/story_page.dart';




class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Widgets for different tabs
  final List<Widget> _tabs = [
    FinanceNewsPage(),
    MyStories(),
    QRPage(),
    MyProfile(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _tabs[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'News'),
          TabItem(icon: Icons.search, title: 'My Stories'),
          TabItem(icon: Icons.qr_code_sharp, title: 'QR'),
          TabItem(icon: Icons.person, title: 'Profile'),
          
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        initialActiveIndex: _selectedIndex,
          backgroundColor: Colors.blueGrey[900], // Задаем цвет AppBar
        activeColor: Colors.white, // Customize the active icon color
      ),
    );
  }
}
