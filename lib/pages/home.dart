import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/widgets/artist_card.dart';
import 'package:rhythmix/widgets/song_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20.0),
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [
            //       Colors.lightGreen,
            //       Colors.transparent,
            //     ],
            //   ),
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text(
                    "Trending Now",
                    style: TextStyle(
                      fontSize: 28,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      SongCard(),
                      SongCard(),
                      SongCard(),
                      SongCard(),
                      SongCard()
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Charts",
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF0C3B2D),
                            ),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "SEE ALL",
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      SongCard(),
                      SongCard(),
                      SongCard(),
                      SongCard(),
                      SongCard()
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Artists",
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF0C3B2D),
                            ),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "SEE ALL",
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      ArtistCard(),
                      ArtistCard(),
                      ArtistCard(),
                      ArtistCard(),
                      ArtistCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
