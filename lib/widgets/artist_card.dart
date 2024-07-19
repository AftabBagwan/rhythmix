import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({super.key, required this.artistImageUrl});
  final String artistImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: CircleAvatar(
        radius: 72,
        backgroundImage: CachedNetworkImageProvider(artistImageUrl),
        onBackgroundImageError: (exception, stackTrace) => const Icon(Icons.error),
        backgroundColor: AppColors.transparent,
      ),
    );
  }
}
