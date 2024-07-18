import 'package:flutter/material.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/utils/colors.dart';

class SongCard extends StatelessWidget {
  const SongCard({super.key, required this.redirectTo, required this.song});
  final void Function() redirectTo;
  final Song song;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: redirectTo,
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 20),
        width: screenWidth * (1 / 3), //120,
        height: screenHeight * 0.2, //160,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * (1 / 3), //120,
              height: screenHeight * 0.15, //120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(song.image.last.url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 2.0),
              child: Text(
                song.name,
                softWrap: false,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
            Text(
              song.artists.primary.first.name,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
