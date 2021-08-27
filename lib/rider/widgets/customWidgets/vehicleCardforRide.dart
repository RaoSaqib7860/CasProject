import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';

class VehicleCardForRide extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final String carType;
  final String cardImg;
  final Color cardColor;

  const VehicleCardForRide(
      {Key key,
      this.cardHeight,
      this.cardWidth,
      this.carType,
      this.cardImg,
      this.cardColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
            color: cardColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: AppColors.secondMainColor.withOpacity(0.5),
            ),
            image: DecorationImage(
              image: AssetImage(cardImg),
              fit: BoxFit.scaleDown,
             matchTextDirection: true,
              alignment: Alignment.center,
            )),
        child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                carType,
                style: AppTextStyles.description1,
              ),
            )),
      ),
    );
  }
}
