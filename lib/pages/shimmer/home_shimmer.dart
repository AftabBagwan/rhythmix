import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerTitle(),
              ShimmerHorizontalList(screenHeight: screenHeight, screenWidth: screenWidth),
              const ShimmerTitle(),
              ShimmerHorizontalList(screenHeight: screenHeight, screenWidth: screenWidth),
              const ShimmerTitle(),
              ShimmerCircleList(screenHeight: screenHeight)
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerTitle extends StatelessWidget {
  const ShimmerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Shimmer.fromColors(
        baseColor: AppColors.black87,
        highlightColor: AppColors.lightGreen,
        child: Container(
          width: 200,
          height: 20,
          color: AppColors.black87,
        ),
      ),
    );
  }
}

class ShimmerHorizontalList extends StatelessWidget {
  const ShimmerHorizontalList({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return ShimmerHorizontalItem(screenHeight: screenHeight, screenWidth: screenWidth);
        },
      ),
    );
  }
}

class ShimmerHorizontalItem extends StatelessWidget {
  const ShimmerHorizontalItem({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.black87,
          highlightColor: AppColors.lightGreen,
          child: Container(
            width: screenWidth * 0.33,
            height: screenHeight * 0.15,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.black87,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const ShimmerLine(width: 80, height: 10),
        const SizedBox(height: 5),
        const ShimmerLine(width: 60, height: 8),
      ],
    );
  }
}

class ShimmerLine extends StatelessWidget {
  const ShimmerLine({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.black87,
      highlightColor: AppColors.lightGreen,
      child: Container(
        width: width,
        height: height,
        color: AppColors.black87,
      ),
    );
  }
}

class ShimmerCircleList extends StatelessWidget {
  const ShimmerCircleList({super.key, required this.screenHeight});

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.225,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(right: 10),
            child: ShimmerCircle(),
          );
        },
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  const ShimmerCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.black87,
      highlightColor: AppColors.lightGreen,
      child: CircleAvatar(
        radius: 72,
        backgroundColor: AppColors.black87,
      ),
    );
  }
}
