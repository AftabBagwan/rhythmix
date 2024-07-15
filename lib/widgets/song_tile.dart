import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.songImage, required this.songName});
  final String songImage;
  final String songName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(songImage), fit: BoxFit.cover),
            ),
          ),
          Text(
            songName,
          ),
        ],
      ),
    );
  }
}
