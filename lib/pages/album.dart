import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';

class AlbumScreen extends StatefulWidget {
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
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);
    final bottombarProvider = Provider.of<BottomNavProvider>(context);

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
                    image: NetworkImage(widget.albumImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              widget.albumName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.releaseDate} . ${widget.albumLangiage} . ${widget.artist}"
                  .toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.songs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        playerProvider.loadSong(widget.songs[index].name);
                        bottombarProvider.changePage(2);
                        playerProvider.songSelected();
                      },
                      title: Text(
                        widget.songs[index].name,
                      ),
                      subtitle: Text(
                        overflow: TextOverflow.ellipsis,
                        "${widget.songs[index].artists.all.first.name} , ${widget.songs[index].artists.all.last.name}",
                      ),
                      trailing: const Icon(
                        Icons.play_circle,
                        size: 32,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
