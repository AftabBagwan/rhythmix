import 'package:flutter/material.dart';
import 'package:rhythmix/pages/genre.dart';
import 'package:rhythmix/utils/colors.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({super.key, required this.genreName});
  final String genreName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenreScreen(genre: genreName),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.greyShade800,
          border: Border.all(color: AppColors.white, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            genreName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
