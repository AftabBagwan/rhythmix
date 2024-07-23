import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/pages/shimmer/player_shimmer.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/widgets/cached_network_image.dart';
import 'package:rhythmix/widgets/common.dart';
import 'package:rhythmix/widgets/player_control_buttons.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    final bottombarProvider = Provider.of<BottomNavProvider>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        bottombarProvider.changePage(0);
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Consumer<PlayerProvider>(
          builder: (context, playerProvider, child) {
            if (playerProvider.isLoading) {
              return const PlayerShimmer();
            } else {
              Song currentSong = playerProvider.currentSong;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 20.0),
                            child: Text(
                              currentSong.name,
                              softWrap: false,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        CachedImage(
                          imageUrl: currentSong.image.last.url,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          margin: const EdgeInsets.only(bottom: 20),
                        ),
                        Text(
                          currentSong.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: false,
                        ),
                        Text(
                          currentSong.artists.primary.first.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.grey,
                          ),
                          softWrap: false,
                        ),
                        StreamBuilder<PositionData>(
                          stream: playerProvider.positionDataStream,
                          builder: (context, snapshot) {
                            final positionData = snapshot.data;
                            return SeekBar(
                              duration: positionData?.duration ?? Duration.zero,
                              position: positionData?.position ?? Duration.zero,
                              bufferedPosition:
                                  positionData?.bufferedPosition ??
                                      Duration.zero,
                              onChangeEnd: playerProvider.player.seek,
                            );
                          },
                        ),
                        Center(
                            child: PlayerControlButtons(playerProvider.player)),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
