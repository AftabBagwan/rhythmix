import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';

class SongCard extends StatelessWidget {
  const SongCard({super.key, this.songImage, this.songName, this.description, this.redirectTo});
  final String? songImage;
  final String? songName;
  final String? description;
  final void Function()? redirectTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: redirectTo,
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 20),
        width: 120,
        height: 160,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    songImage ??
                        "https://assets-in.bmscdn.com/iedb/movies/images/mobile/thumbnail/xlarge/pushpa--the-rise-et00129538-08-12-2021-01-21-46.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 2.0),
              child: Text(
                songName ?? "Pushpa - The Rise",
                softWrap: false,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
            Text(
              description ?? "Single - Devi Sri Prasad",
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
