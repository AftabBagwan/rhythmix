import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/utils/colors.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key, required this.songs});
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);
    final bottombarProvider = Provider.of<BottomNavProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: screenHeight * (1 / 4), //200
                width: screenWidth * (0.55), //200
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(songs[0].image.last.url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              songs[0].album.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${songs[0].year} . ${songs[0].language} . ${songs[0].artists.primary.first.name}"
                  .toUpperCase(),
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      playerProvider.selectSong(songs[index]);
                      playerProvider.selectSongQueue(songs);
                      bottombarProvider.changePage(1);
                      playerProvider.songSelected();
                    },
                    title: Text(songs[index].name),
                    subtitle: Text(
                      overflow: TextOverflow.ellipsis,
                      "${songs[index].artists.all.first.name} , ${songs[index].artists.all.last.name}",
                    ),
                    trailing: const Icon(
                      Icons.play_circle,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
