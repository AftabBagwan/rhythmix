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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Shimmer.fromColors(
                    baseColor: AppColors.black87,
                    highlightColor: AppColors.greyShade100,
                    child: Container(
                      width: 200,
                      height: 30,
                      color: AppColors.black87,
                    ),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: AppColors.black87,
                highlightColor: AppColors.greyShade100,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: AppColors.black87,
                highlightColor: AppColors.greyShade100,
                child: Container(
                  width: 200,
                  height: 30,
                  color: AppColors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: AppColors.black87,
                highlightColor: AppColors.greyShade100,
                child: Container(
                  width: 150,
                  height: 20,
                  color: AppColors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Shimmer.fromColors(
                baseColor: AppColors.black87,
                highlightColor: AppColors.greyShade100,
                child: Container(
                  width: double.infinity,
                  height: 10,
                  color: AppColors.black87,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.black87,
                    highlightColor: AppColors.greyShade100,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.black87,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppColors.black87,
                        highlightColor: AppColors.greyShade100,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Shimmer.fromColors(
                        baseColor: AppColors.black87,
                        highlightColor: AppColors.greyShade100,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Shimmer.fromColors(
                        baseColor: AppColors.black87,
                        highlightColor: AppColors.greyShade100,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Shimmer.fromColors(
                    baseColor: AppColors.black87,
                    highlightColor: AppColors.greyShade100,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
