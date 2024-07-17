import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/providers/artist_provider.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/utils/constants.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key, required this.artistName});
  final String artistName;

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  
  @override
  void initState() {
    super.initState();
    // Using a post-frame callback to ensure it runs after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final artistProvider =
          Provider.of<ArtistProvider>(context, listen: false);
      artistProvider.loadArtistSongs(widget.artistName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);
    final bottombarProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(artistImage[widget.artistName]),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.artistName} ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: Image(image: AssetImage("assets/verified.png")),
                  )
                ],
              ),
              Text(
                "Popular",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.grey,
                ),
              ),
              Expanded(
                child: Consumer<ArtistProvider>(
                  builder: (context, artistProvider, child) {
                    if (artistProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (artistProvider.artistSongs == null) {
                      return const Center(child: Text('No songs found.'));
                    } else {
                      return ListView.builder(
                        itemCount:
                            artistProvider.artistSongs?.data.results.length,
                        itemBuilder: (context, index) {
                          final song =
                              artistProvider.artistSongs?.data.results[index];
                          return ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              playerProvider.loadSong(song.name);
                              bottombarProvider.changePage(1);
                              playerProvider.songSelected();
                            },
                            contentPadding: EdgeInsets.zero,
                            title: Text(song!.name),
                            subtitle: Text(song.artists.primary.first.name),
                            leading: Container(
                              width: 55,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(song.image.last.url),
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
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
