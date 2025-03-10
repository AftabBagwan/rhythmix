import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/widgets/common.dart';

class PlayerControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const PlayerControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.volume_up,
            size: 32,
          ),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (playerProvider.index > 0) {
                  playerProvider.selectSong(
                      playerProvider.songQueue[playerProvider.index - 1]);
                  playerProvider.setIndex(playerProvider.index - 1);
                }
              },
              icon: const Icon(
                Icons.skip_previous,
                size: 32,
              ),
            ),
            StreamBuilder<PlayerState>(
              stream: player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 64.0,
                    height: 64.0,
                    child: CircularProgressIndicator(
                      color: AppColors.black87,
                    ),
                  );
                } else if (playing != true) {
                  return IconButton(
                    icon: const Icon(Icons.play_circle),
                    iconSize: 64.0,
                    onPressed: () {
                      playerProvider.playSong();
                      playerProvider.songSelected();
                    },
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                      icon: const Icon(Icons.pause_circle),
                      iconSize: 64.0,
                      onPressed: () {
                        playerProvider.pauseSong();
                      });
                } else {
                  if (playerProvider.index <
                      playerProvider.songQueue.length - 1) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      playerProvider.selectSong(
                          playerProvider.songQueue[playerProvider.index + 1]);
                      playerProvider.setIndex(playerProvider.index + 1);
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      playerProvider.selectSong(playerProvider.songQueue[0]);
                      playerProvider.setIndex(0);
                    });
                  }
                  return IconButton(
                    icon: const Icon(Icons.replay),
                    iconSize: 64.0,
                    onPressed: () => player.seek(Duration.zero),
                  );
                }
              },
            ),
            IconButton(
              onPressed: () {
                if (playerProvider.index <
                    playerProvider.songQueue.length - 1) {
                  playerProvider.selectSong(
                      playerProvider.songQueue[playerProvider.index + 1]);
                  playerProvider.setIndex(playerProvider.index + 1);
                } else {
                  playerProvider.selectSong(playerProvider.songQueue[0]);
                  playerProvider.setIndex(0);
                }
              },
              icon: const Icon(
                Icons.skip_next,
                size: 32,
              ),
            ),
            // Opens speed slider dialog
          ],
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(Icons.repeat, size: 28),
            // Text("${snapshot.data?.toStringAsFixed(1)}x",
            //     style:
            //         const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
            // ),
            onPressed: () {
              if (playerProvider.index != 0) {
                playerProvider.selectSong(playerProvider.songQueue[0]);
                playerProvider.setIndex(0);
              }
              // showSliderDialog(
              //   context: context,
              //   title: "Adjust speed",
              //   divisions: 10,
              //   min: 0.5,
              //   max: 1.5,
              //   value: player.speed,
              //   stream: player.speedStream,
              //   onChanged: player.setSpeed,
              // );
            },
          ),
        ),
      ],
    );
  }
}
