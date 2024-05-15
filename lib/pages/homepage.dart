import 'package:flutter/material.dart';
import '../widgets/mainmenu.dart';
import './profile.dart';
import './pesanan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Stack(
        children: [
          Container(
            color: Color(0xFF131311),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 80),
            child: Text(
              "Great Gentleman Style!",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 220),
            child: Text(
              "Let your hair do the talking",
              style: TextStyle(
                fontSize: 27,
                color: Colors.white,
              ),
            ),
          ),
          mainMenu(),
        ],
      ),
      Center(
        child: Pesanan(),
      ),
      Center(
        child: Profile(),
      ),
    ];

    return Scaffold(
      body: widgets[currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // indicatorColor: Colors.yellow.shade300,
          indicatorColor: Color(0xFF96652B),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Color(0xFF131311),
          selectedIndex: currentIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: Duration(seconds: 1),
          onDestinationSelected: (index) =>
              setState(() => this.currentIndex = index),
          destinations: [
            NavigationDestination(
              icon: ImageIcon(
                AssetImage("icons/home_icon.png"),
                size: 33,
                color: Colors.white,
              ),
              label: 'Home',
              selectedIcon: ImageIcon(
                AssetImage("icons/home_icon.png"),
                size: 29,
                color: Colors.white,
              ),
              // color: Colors.white,
              // size: 30,
            ),
            NavigationDestination(
              icon: ImageIcon(
                AssetImage("icons/list_icon.png"),
                size: 33,
                color: Colors.white,
              ),
              label: 'Pesanan',
              selectedIcon: ImageIcon(
                AssetImage("icons/list_icon.png"),
                size: 29,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: ImageIcon(
                AssetImage("icons/profile_icon.png"),
                size: 33,
                color: Colors.white,
              ),
              label: 'Profile',
              selectedIcon: ImageIcon(
                AssetImage("icons/profile_icon.png"),
                size: 29,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
