import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/pages/home.dart';
import 'package:rhythmix/pages/player.dart';
import 'package:rhythmix/pages/search.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
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
              Icons.music_note,
            ),
            label: "Player",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0x00ffffff),
        iconSize: 36,
        currentIndex: provider.currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          provider.changePage(index);
        },
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
        controller: provider.pageController,
        children: const [
          Home(),
          Search(),
          Player(),
          Scaffold(
            body: Center(
              child: Text("Profile"),
            ),
          ),
        ],
      ),
    );
  }
}
