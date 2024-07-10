import 'package:flutter/material.dart';
import 'package:rhythmix/pages/home.dart';
import 'package:rhythmix/pages/search.dart';

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
        // useMaterial3: true,
      ),
      home: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
                Icons.home_filled,
            ),
              label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.my_library_music_sharp,
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
          backgroundColor: Color(0x00ffffff),
          iconSize: 36,
        currentIndex: selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
        elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
          ),
      ),
        body: PageView(
          controller: _pageController,
          children: const [
            Home(),
            Search(),
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
