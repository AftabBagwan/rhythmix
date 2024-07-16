import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/utils/constants.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key, this.artist});
  final artist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(artistImage[artist]),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$artist ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: Image(image: AssetImage("assets/verified.png")),
                  )
                ],
              ),
              Text(
                "Popular",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
