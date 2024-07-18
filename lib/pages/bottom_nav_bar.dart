import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/pages/home.dart';
import 'package:rhythmix/pages/player.dart';
import 'package:rhythmix/pages/search.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/widgets/song_snack_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SongSnackBar(),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.music_note,
                ),
                label: "Player",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Search",
              ),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0x00ffffff),
            iconSize: 36,
            currentIndex: provider.currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.grey,
            onTap: (index) {
              provider.changePage(index);
            },
            elevation: 0,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.white,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightGreen,
              Colors.transparent,
            ],
          ),
        ),
        child: PageView(
          controller: provider.pageController,
          children: [
            const Home(),
            const Player(),
            Search(),
          ],
        ),
      ),
    );
  }
}
