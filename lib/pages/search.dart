import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/providers/search_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/widgets/genre_card.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);
    final bottombarProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Consumer<SearchProvider>(
          builder: (context, searchProvider, child) {
            if (searchProvider.genreList.isEmpty) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.black87),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 16),
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, size: 32),
                    hintText: "Artist, Song or Podcast",
                    hintStyle: const TextStyle(fontSize: 16),
                    prefixIconColor: AppColors.white,
                    fillColor: AppColors.greyShade800,
                    focusColor: AppColors.greyShade800,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: searchProvider.searchKeyword,
                ),
                const SizedBox(height: 20),
                Text(
                  "Browse all",
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: _searchController.text.isEmpty
                      ? GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                          ),
                          itemCount: searchProvider.genreList.length,
                          itemBuilder: (context, index) {
                            return GenreCard(
                              genreName: searchProvider.genreList[index],
                            );
                          },
                        )
                      : searchProvider.loading || searchProvider.searchSongResult == null
                          ? Center(
                              child: CircularProgressIndicator(color: AppColors.black87),
                            )
                          : ListView.builder(
                              itemCount: searchProvider.searchSongResult?.data.songs.length,
                              itemBuilder: (context, index) {
                                List<Song> songs = searchProvider.searchSongResult!.data.songs;
                                return ListTile(
                                  onTap: () {
                                    playerProvider.selectSong(songs[index]);
                                    playerProvider.selectSongQueue(songs);
                                    bottombarProvider.changePage(1);
                                    playerProvider.songSelected();
                                    _searchController.clear();
                                    FocusScope.of(context).unfocus();
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(songs[index].name),
                                  subtitle: Text(songs[index].artists.all.first.name),
                                  leading: Container(
                                    width: 55,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(songs[index].image.last.url),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  trailing: const Icon(Icons.play_circle, size: 32),
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
