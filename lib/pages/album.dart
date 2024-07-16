import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen(
      {super.key,
      required this.albumImage,
      required this.albumName,
      required this.releaseDate,
      required this.albumLangiage,
      required this.artist,
      required this.songs});
  final String albumImage;
  final String albumName;
  final String releaseDate;
  final String albumLangiage;
  final String artist;
  final List<Result> songs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(albumImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              albumName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$releaseDate . $albumLangiage . $artist".toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      songs[index].name,
                    ),
                    subtitle: Text(
                      overflow: TextOverflow.ellipsis,
                      "${songs[index].artists.all.first.name} , ${songs[index].artists.all.last.name}",
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_circle,
                          size: 32,
                        )),
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
