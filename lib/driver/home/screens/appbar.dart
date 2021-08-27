import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAppBar extends StatelessWidget {
  final double barHeight = 66.0;

  const MyAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Icon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
          ),
          Container(
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            child: Icon(
              FontAwesomeIcons.userCircle,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/*


 //
                  // ================== To && From Paths ================ \\
                  //

                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.05, right: width * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x20000000),
                                blurRadius: 10.0,
                                spreadRadius: 10.0,
                                offset: Offset(0, 3))
                          ]),
                      height: height * 0.2,
                      // color: Colors.white,
                      child: Row(
                        children: [
                          //
                          //================== Vertical Destination Points =======================\\
                          //
                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.03,
                              left: width * 0.05,
                            ),
                            child: Container(
                              //    color: Colors.orange,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    height: height * 0.08,
                                    //  color: Colors.blue,
                                    child: VerticalDivider(
                                      thickness: 1.5,
                                      width: 10,

                                      //height: height * 0.1,

                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.radio_button_unchecked,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //
                          //==================== End Vertical Destination Points =======================\\
                          //

                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.018,
                              left: width * 0.04,
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "From:",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Container(
                                          width: width * 0.73,
                                          child: AutoSizeText(
                                            "${model.fromAddress}",
                                            maxLines: 2,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.04),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "To:",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Container(
                                            width: width * 0.73,
                                            child: AutoSizeText(
                                              "${model.toAddress}",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

*/
