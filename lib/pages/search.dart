import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/widgets/genre_card.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 28,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                child: Text(
                  "Browse all",
                  style: TextStyle(
                    fontSize: 28,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                  ),
                  children: [
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                    GenreCard(),
                  ],
                ),
              )
            ],
          ),
          
        ),
      ),
    );
  }
}
