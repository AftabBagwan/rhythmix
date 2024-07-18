import 'package:flutter/material.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/utils/colors.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({super.key, required this.redirectTo, required this.album});
  final void Function() redirectTo;
  final Song album;

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
                    album.image.last.url,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 2.0),
              child: Text(
                album.album.name,
                softWrap: false,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
            Text(
              album.artists.primary.first.name,
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
