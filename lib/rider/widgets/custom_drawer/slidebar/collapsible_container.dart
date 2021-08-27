import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CollapsibleContainer extends StatelessWidget {
  const CollapsibleContainer({
    @required this.height,
    @required this.width,
    @required this.padding,
    @required this.borderRadius,
    @required this.color,
    @required this.child,
  });

  final double height, width, padding, borderRadius;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      borderRadius: 15,
      blur: 1.8,
      alignment: Alignment.center,
      border: 0,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mainColor.withOpacity(0.2),
            AppColors.secondMainColor.withOpacity(0.3),
          ],
          stops: [
            0.1,
            1,
          ]),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.05),
          color,
        ],
      ),
      height: height*0.88,
      width: width-10,
      padding: EdgeInsets.all(padding),

      child: child,
    );
  }
}
