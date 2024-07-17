import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/pages/bottom_nav_bar.dart';
import 'package:rhythmix/providers/artist_provider.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/home_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArtistProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors.primaryColor,
          useMaterial3: true,
        ),
        home: const BottomNavBar(),
        ),
    );
  }
}
