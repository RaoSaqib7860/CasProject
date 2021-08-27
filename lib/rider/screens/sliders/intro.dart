import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/Commons/choose_account_type_screen.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroSliderGSR extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<IntroSliderGSR> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ChooseAccountType()),
    );
  }

  Widget _buildImage(Image introImg) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          color: Colors.transparent,
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: introImg,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white12,
      imagePadding: EdgeInsets.zero,
    );

    return Material(
      type: MaterialType.canvas,
      color: AppColors.secondMainColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.greyColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: GlassmorphicContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              borderRadius: 20,
              blur: 20,
              alignment: Alignment.bottomCenter,
              border: 2,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.mainColor.withOpacity(0.1),
                    AppColors.secondMainColor.withOpacity(0.05),
                  ],
                  stops: [
                    0.1,
                    1,
                  ]),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff).withOpacity(0.5),
                  Color((0xFFFFFFFF)).withOpacity(0.5),
                ],
              ),
              child: IntroductionScreen(
                key: introKey,

                pages: [
                  PageViewModel(
                    //  title: "Get Smart Ride",
                    titleWidget: Text(
                      "Get Smart Ride",
                      style: AppTextStyles.heading1,
                    ),
                    footer: MaterialButton(
                      color: AppColors.greenColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      colorBrightness: Brightness.light,
                      onPressed: () => () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Login as rider",
                          style: AppTextStyles.btnStyle,
                        ),
                      ),
                    ),
                    bodyWidget: Text(
                      "City to city and within the city rides,",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.description1,
                    ),
                    image:
                        _buildImage(Image.asset('images/introNavigation.png')),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    titleWidget: Text(
                      "Get Smart Ride",
                      style: AppTextStyles.heading1,
                    ),
                    bodyWidget: Text(
                      "City to city and within the city rides,",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.description1,
                    ),
                    image: _buildImage(Image.asset('images/newRidebg.png')),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    titleWidget: Text(
                      "Get Smart Ride",
                      style: AppTextStyles.heading1,
                    ),
                    bodyWidget: Text(
                      "City to city and within the city rides,",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.description1,
                    ),
                    image: _buildImage(Image.asset('images/intro3.png')),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    titleWidget: Text(
                      "Get Smart Ride",
                      style: AppTextStyles.heading1,
                    ),
                    bodyWidget: Text(
                      "City to city and within the city rides,",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.description1,
                    ),
                    image: _buildImage(Image.asset('images/intro4.jpg')),
                    footer: RaisedButton(
                      elevation: 3,
                      onPressed: () {
                        introKey.currentState?.animateScroll(0);
                      },
                      child: Text(
                        'www.GetSmartRide.com',
                        style: AppTextStyles.heading3.copyWith(
                            fontSize: 15, color: AppColors.whiteColor),
                      ),
                      color: AppColors.mainColor.withOpacity(0.85),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    decoration: pageDecoration,
                  ),
                ],
                onDone: () => _onIntroEnd(context),
                //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
                showSkipButton: true,
                skipFlex: 0,
                nextFlex: 0,
                skip: const Text('Skip'),

                next: const Icon(Icons.arrow_forward),
                done: const Text('Done',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                dotsDecorator: const DotsDecorator(
                  size: Size(10.0, 10.0),
                  color: Color(0xFFBDBDBD),
                  activeSize: Size(22.0, 10.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
