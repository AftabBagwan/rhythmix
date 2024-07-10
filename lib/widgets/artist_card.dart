import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 32.0),
      child: CircleAvatar(
        radius: 120,
        backgroundImage: NetworkImage(
            "https://static.toiimg.com/thumb/imgsize-23456,msid-99213152,width-600,resizemode-4/99213152.jpg"),
      ),
    );
  }
}
