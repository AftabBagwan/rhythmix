import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            Text(
              "Search",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
