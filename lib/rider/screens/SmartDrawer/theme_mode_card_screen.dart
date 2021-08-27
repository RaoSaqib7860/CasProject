import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';

class ChangeThemeModeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
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
            ),
          ),
        ),
      ),
    );
  }
}
