import 'package:flutter/material.dart';
import 'package:rhythmix/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF222831),
      ),
      home: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Player",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_music,
            ),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF222831),
        iconSize: 32,
        currentIndex: selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          Scaffold(
            body: Center(
              child: Text("Home"),
            ),
          ),
          Scaffold(
            body: Center(
              child: Text("Search"),
            ),
          ),
          Scaffold(
            body: Center(
              child: Text("Library"),
            ),
          ),
          Scaffold(
            body: Center(
              child: Text("Profile"),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
