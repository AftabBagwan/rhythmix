import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/utils/colors.dart';

class SongSnackBar extends StatelessWidget {
  const SongSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        if (bottomNavProvider.currentIndex != 0 ||
            !playerProvider.hasSelectedSong) {
          return const SizedBox.shrink();
        } else {
          Song currentSong = playerProvider.currentSong;
          return GestureDetector(
            onTap: () {
              bottomNavProvider.changePage(1);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.075, //60,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            currentSong.image.last.url),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            currentSong.name,
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            currentSong.artists.primary.first.name,
                            style:
                                TextStyle(color: AppColors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                        playerProvider.player.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: AppColors.white),
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
            ),
          );
        }
      },
    );
  }
}
