import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class PlayerShimmer extends StatelessWidget {
  const PlayerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: ShimmerRectangle(width: 200, height: 30),
                ),
              ),
              ShimmerRectangle(
                width: double.infinity,
                height: 300,
                margin: EdgeInsets.only(bottom: 20),
                borderRadius: 10,
              ),
              ShimmerRectangle(width: 200, height: 30),
              SizedBox(height: 10),
              ShimmerRectangle(width: 150, height: 20),
              SizedBox(height: 20),
              ShimmerRectangle(width: double.infinity, height: 10),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerCircle(size: 40),
                  Row(
                    children: [
                      ShimmerCircle(size: 40),
                      SizedBox(width: 20),
                      ShimmerCircle(size: 60),
                      SizedBox(width: 20),
                      ShimmerCircle(size: 40),
                    ],
                  ),
                  ShimmerCircle(size: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerRectangle extends StatelessWidget {
  const ShimmerRectangle({
    super.key,
    required this.width,
    required this.height,
    this.margin,
    this.borderRadius = 0,
  });

  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.black87,
      highlightColor: AppColors.greyShade100,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: AppColors.black87,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  const ShimmerCircle({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.black87,
      highlightColor: AppColors.greyShade100,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.black87,
        ),
      ),
    );
  }
}
