import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';

class CancelledRidesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        color: AppColors.greyColor.withOpacity(0.5),
        child: FadeInLeft(
          animate: true,
          child: Card(
            color: AppColors.secondMainColor.withOpacity(0.5),
            margin: const EdgeInsets.only(
                left: 100, bottom: 185, top: 170, right: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: Card(
                      color: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: SizedBox(
                        height: constraints.maxHeight * 0.035,
                        width: constraints.maxWidth * 0.45,
                        child: Center(
                          child: Text(
                            'Cancelled Rides',
                            style: AppTextStyles.description1
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Till Today',
                                    style: AppTextStyles.heading2small
                                        .copyWith(color: AppColors.greyColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Total',
                                        style: AppTextStyles.heading3White
                                            .copyWith(fontSize: 15),
                                      ),
                                      Card(
                                        color: AppColors.whiteColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        elevation: 5,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: SizedBox(
                                          height: constraints.maxHeight * 0.045,
                                          width: constraints.maxWidth * 0.25,
                                          child: Center(
                                            child: Text(
                                              '5 rides',
                                              style: AppTextStyles.description1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Card(
                              color: AppColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              elevation: 5,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: SizedBox(
                                height: constraints.maxHeight * 0.045,
                                width: constraints.maxWidth * 0.25,
                                child: Center(
                                  child: Text(
                                    'Insights',
                                    style: AppTextStyles.description1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
