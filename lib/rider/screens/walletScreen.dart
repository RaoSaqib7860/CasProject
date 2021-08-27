
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:slimy_card/slimy_card.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  color: Colors.transparent,
                  child: StreamBuilder<Object>(
                      initialData: false,
                      stream: slimyCard.stream,
                      builder: (context, snapshot) {
                        return SlimyCard(
                          color: AppColors.mainColor,
                          borderRadius: 15,
                          bottomCardHeight: 100,
                          width: constraints.maxWidth * 0.85,

                          slimeEnabled: true,
                          topCardHeight: constraints.maxHeight * 0.4,
                          // In topCardWidget below, imagePath changes according to the
                          // status of the SlimyCard(snapshot.data).
                          topCardWidget: topCardWidget((snapshot.data)
                              ? '650 RS'
                              : '650 RS'),
                          bottomCardWidget: bottomCardWidget(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget topCardWidget(String amountWallet) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          // image: DecorationImage(image: AssetImage(imagePath)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
            child: Text(
          amountWallet,
          style:
              AppTextStyles.description1.copyWith(fontSize: 18),
        )),
      ),
      SizedBox(height: 15),
      Text(
        'penalty',
        style: AppTextStyles.btnStyle,
      ),
      SizedBox(height: 15),
      Text(
        'you cancelled 2 rides',
        style:
            AppTextStyles.heading2small.copyWith(color: AppColors.whiteColor,fontSize: 13),
      ),
      SizedBox(height: 10),
    ],
  );
}

// This widget will be passed as Bottom Card's Widget.
Widget bottomCardWidget() {

  return Text('You have to pay this',style: AppTextStyles.btnStyle,);
   // return Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //   children: [
  //     GestureDetector(
  //       child: MaterialButton(
  //         color: AppColors.secondMainColor.withOpacity(0.5),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         onPressed: () => print('ddddd'),
  //         child: Row(
  //           children: [
  //
  //             Text(
  //               'JazzCash',
  //               style: AppTextStyles.description1.copyWith(color: AppColors.whiteColor),
  //               textAlign: TextAlign.center,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     GestureDetector(
  //       child: MaterialButton(
  //         color: AppColors.secondMainColor.withOpacity(0.5),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         onPressed: () => print('ddddd'),
  //         child: Row(
  //           children: [
  //
  //             Text(
  //               'PayPak',
  //               style: AppTextStyles.description1.copyWith(color: AppColors.whiteColor),
  //               textAlign: TextAlign.center,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     GestureDetector(
  //       child: MaterialButton(
  //         color: AppColors.secondMainColor.withOpacity(0.5),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         onPressed: () => print('ddddd'),
  //         child: Row(
  //           children: [
  //
  //             Text(
  //               'Other',
  //               style: AppTextStyles.description1.copyWith(color: AppColors.whiteColor),
  //               textAlign: TextAlign.center,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ],
  // );
}
