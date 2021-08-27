import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DriverDashBoardSlider extends StatefulWidget {
  var height, width;

  DriverDashBoardSlider({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  _DriverDashBoardSliderState createState() => _DriverDashBoardSliderState();
}

class _DriverDashBoardSliderState extends State<DriverDashBoardSlider> {
  List<String> sliderImageList = List();

  getSliderImages() {
    sliderImageList.add("images/slider_image1.jpg");

    sliderImageList.add("images/slider_image2.jpg");
  }

  @override
  void initState() {
    getSliderImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        //  padding: EdgeInsets.only(top: statusBarHeight),
        height: widget.height * 0.3,
        //  color: Colors.red,
        child: CarouselSlider(
          options: CarouselOptions(
            // disableCenter: true,
            autoPlay: true,

            enlargeCenterPage: true,

            // enlargeStrategy: CenterPageEnlargeStrategy.height,
            // enableInfiniteScroll: false,
            initialPage: 2,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.9,
          ),
          items: sliderImageList
              .map((item) => Container(
                    height: widget.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: AssetImage(item), fit: BoxFit.fill)),
                    // child: Image.asset(item,
                    //     fit: BoxFit.fill, width: 1000),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
