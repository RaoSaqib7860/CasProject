import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  static var index = 1;
  PageTwo({
    Key key,
  }) : super(key: key);

  @override
  _PageTwo createState() => _PageTwo();
}

class _PageTwo extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
