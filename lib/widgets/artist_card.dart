import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({super.key, required this.artistImageUrl});
  final String artistImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: CircleAvatar(
        radius: 72,
        backgroundImage: NetworkImage(
            artistImageUrl),
      ),
    );
  }
}
