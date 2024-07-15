import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/remote.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/utils/constants.dart';
import 'package:rhythmix/widgets/genre_card.dart';
import 'package:rhythmix/widgets/song_tile.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  late SearchSong searchSongResult;

  void searchKeyword(String query) async {
    var result = await searchSong(query);
    setState(() {
      searchSongResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
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
                onChanged: searchKeyword,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              Expanded(
                child: ListView.builder(
                  itemCount: searchSongResult.data.results.length,
                  itemBuilder: (context, index) {
                    return SongTile(
                      songImage:
                          searchSongResult.data.results[index].image.last.url,
                      songName: searchSongResult.data.results[index].name,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}