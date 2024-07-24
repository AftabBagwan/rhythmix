import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/pages/home.dart';
import 'package:rhythmix/pages/offline.dart';
import 'package:rhythmix/pages/player.dart';
import 'package:rhythmix/pages/search.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/utils/utils.dart';
import 'package:rhythmix/widgets/song_snack_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    Utils.checkInternet().then((value) {
      if (!value) {
        Navigator.push(context,
            (MaterialPageRoute(builder: (context) => const OfflineScreen())));
      }
    });
  }

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
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: "Player",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.transparent, //const Color(0x00ffffff),
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
            unselectedLabelStyle: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.lightGreen,
              AppColors.transparent,
            ],
          ),
        ),
        child: PageView(
          controller: provider.pageController,
          physics: const NeverScrollableScrollPhysics(),
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
