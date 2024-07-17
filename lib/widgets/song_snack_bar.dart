import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';

class SongSnackBar extends StatelessWidget {
  const SongSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        if (bottomNavProvider.currentIndex == 1 ||
            !playerProvider.hasSelectedSong ||
            playerProvider.currentSong == null) {
          return const SizedBox.shrink();
        } else {
          return Container(
            height: 60,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        playerProvider
                            .currentSong.data.results[0].image.last.url,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playerProvider.currentSong.data.results[0].name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      playerProvider.currentSong.data.results[0].artists.primary
                          .first.name,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                      playerProvider.player.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white),
                  onPressed: () {
                    if (playerProvider.player.playing) {
                      playerProvider.pauseSong();
                    } else {
                      playerProvider.playSong();
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
