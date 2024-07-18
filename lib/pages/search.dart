import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/providers/player_provider.dart';
import 'package:rhythmix/providers/search_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/utils/constants.dart';
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
        child:
            Consumer<SearchProvider>(builder: (context, searchProvider, child) {
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
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 32,
                    ),
                    hintText: "Artist,Song or Podcast",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    prefixIconColor: AppColors.white,
                    fillColor: Colors.grey.shade800,
                    focusColor: Colors.grey.shade800,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onChanged: searchProvider.searchKeyword,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Browse all",
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_searchController.text.isEmpty)
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: genreList.length,
                    itemBuilder: (context, index) {
                      return GenreCard(
                        genreName: genreList[index],
                      );
                    },
                  ),
                ),
              if (_searchController.text.isNotEmpty)
                (searchProvider.searchSongResult == null ||
                        searchProvider.loading)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :
              Expanded(
                child: ListView.builder(
                          itemCount: searchProvider
                              .searchSongResult?.data.songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        playerProvider.selectSong(
                            searchProvider
                                    .searchSongResult!
                                    .data
                                    .songs[index]
                                    );
                        bottombarProvider.changePage(1);
                        playerProvider.songSelected();
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                      },
                      contentPadding: EdgeInsets.zero,
                              title: Text(searchProvider
                                  .searchSongResult!.data.songs[index].name),
                              subtitle: Text(searchProvider.searchSongResult!
                          .data.songs[index].artists.all.first.name),
                      leading: Container(
                        width: 55,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                      searchProvider.searchSongResult!.data
                                          .songs[index].image.last.url,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.play_circle,
                        size: 32,
                      ),
                            );
                  },
                ),
              ),
            ],
          );
        }
        ),
      ),
    );
  }
}
