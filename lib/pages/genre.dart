import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/genre_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key, required this.genre});
  final String genre;

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  void initState() {
    super.initState();
    // Using a post-frame callback to ensure it runs after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final genreProvider = Provider.of<GenreProvider>(context, listen: false);
      genreProvider.loadGenreSongs(widget.genre);
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);
    final bottombarProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
                child: Text(
                  "Hot Hits ${widget.genre}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer<GenreProvider>(
                builder: (context, genreProvider, child) {
                  if (genreProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (genreProvider.genreSongs == null) {
                    return const Center(child: Text('No songs found.'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount:
                            genreProvider.genreSongs?.data.results.length,
                        itemBuilder: (context, index) {
                          var song =
                              genreProvider.genreSongs?.data.results[index];
                          return ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              playerProvider.loadSong(song.name);
                              bottombarProvider.changePage(2);
                              playerProvider.songSelected();
                            },
                            title: Text(song!.name),
                            subtitle: Text(song.artists.primary.first.name),
                            leading: Container(
                              width: 55,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    song.image.last.url,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.play_circle,
                              size: 32,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
