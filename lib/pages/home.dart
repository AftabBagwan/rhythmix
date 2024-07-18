import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/pages/album.dart';
import 'package:rhythmix/pages/artist.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/home_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/utils/constants.dart';
import 'package:rhythmix/widgets/album_card.dart';
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
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    final playerProvider = Provider.of<PlayerProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              if (homeProvider.isLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Text(
                          "Trending Now",
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeProvider.trendingSongs.length,
                          itemBuilder: (context, index) {
                            Song song = homeProvider.trendingSongs[index];
                            return SongCard(
                              redirectTo: () {
                                playerProvider.selectSong(song);
                                playerProvider.selectSongQueue(homeProvider.trendingSongs);
                                bottomNavProvider.changePage(1);
                                playerProvider.songSelected();
                              },
                              song: song,
                            );
                          },
                        ),
                      ),
                      Text(
                        "Top Albums",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeProvider.topAlbumSongs.length,
                          itemBuilder: (context, index) {
                            return AlbumCard(
                              album: homeProvider.topAlbumSongs[index][0],
                              redirectTo: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumScreen(
                                      songs: homeProvider.topAlbumSongs[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Text(
                        "Popular Artists",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: artist.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ArtistScreen(artistName: artist[index]),
                                  ),
                                );
                              },
                              child: ArtistCard(
                                artistImageUrl: artistImage[artist[index]],
                              ),
                            );
                          },
                        ),
                      ),
                      if (playerProvider.hasSelectedSong)
                        const SizedBox(
                          height: 80,
                        ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
