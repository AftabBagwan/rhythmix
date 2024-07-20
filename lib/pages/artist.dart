import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/providers/artist_provider.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/widgets/cached_network_image.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key, required this.artistName, required this.artistImage});
  final String artistName;
  final String artistImage;

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  void initState() {
    super.initState();
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedImage(
                  height: screenHeight * (1 / 4), //200
                  width: screenWidth * (0.55), //200
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  imageUrl: widget.artistImage,
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
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColors.grey,
                      ));
                    } else if (artistProvider.artistSongs == null) {
                      return const Center(child: Text('No songs found.'));
                    } else {
                      return ListView.builder(
                        itemCount:
                            artistProvider.artistSongs?.data.songs.length,
                        itemBuilder: (context, index) {
                          final song =
                              artistProvider.artistSongs?.data.songs[index];
                          return ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              playerProvider.selectSong(song);
                              playerProvider.selectSongQueue(
                                  artistProvider.artistSongs!.data.songs);
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
                                  image: CachedNetworkImageProvider(
                                      song.image.last.url),
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
