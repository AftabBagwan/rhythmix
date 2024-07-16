import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/pages/album.dart';
import 'package:rhythmix/pages/artist.dart';
import 'package:rhythmix/providers/home_provider.dart';
import 'package:rhythmix/services/remote.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/utils/constants.dart';
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
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              if (homeProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
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
                            fontSize: 22,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
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
                            "Top Albums",
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeProvider.topAlbumSongs.length,
                          itemBuilder: (context, index) {
                            return SongCard(
                              songImage: homeProvider.topAlbumSongs[index].data
                                  .results[0].image.last.url,
                              songName: homeProvider.topAlbumSongs[index].data
                                  .results[0].album.name,
                              description: homeProvider.topAlbumSongs[index]
                                  .data.results[0].artists.primary.first.name,
                              redirectTo: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumScreen(
                                      albumImage: homeProvider
                                          .topAlbumSongs[index]
                                          .data
                                          .results[0]
                                          .image
                                          .last
                                          .url,
                                      albumName: homeProvider
                                          .topAlbumSongs[index]
                                          .data
                                          .results[0]
                                          .album
                                          .name,
                                      releaseDate: homeProvider
                                          .topAlbumSongs[index]
                                          .data
                                          .results[0]
                                          .year,
                                      albumLangiage: homeProvider
                                          .topAlbumSongs[index]
                                          .data
                                          .results[0]
                                          .language,
                                      artist: homeProvider
                                          .topAlbumSongs[index]
                                          .data
                                          .results[0]
                                          .artists
                                          .primary
                                          .first
                                          .name,
                                      songs: homeProvider
                                          .topAlbumSongs[index].data.results,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Artists",
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                                        ArtistScreen(artist: artist[index]),
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
