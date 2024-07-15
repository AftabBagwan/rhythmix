import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.songImage, required this.songName});
  final String songImage;
  final String songName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            padding: const EdgeInsets.only(left: 20),
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
