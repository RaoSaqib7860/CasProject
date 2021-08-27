import 'dart:math';

import 'package:flutter/material.dart';

enum ClipType { Left, Right }

class LoginBackgroundClipper extends CustomClipper<Path> {
  ClipType clipType;

  LoginBackgroundClipper({this.clipType});

  @override
  getClip(Size size) {
    var path = new Path();
    if (clipType == ClipType.Left) {
      createLeft(size, path);
    } else if (clipType == ClipType.Right) {
      createRight(size, path);
    }
    path.close();
    return path;
  }

  createLeft(Size size, Path path) {
    path.moveTo(size.width * 0, size.height * 0);
    path.lineTo(size.width * 0, size.height * 0.8);

    path.lineTo(size.width * 1, size.height * 0.2);

    path.lineTo(size.width * 1, size.height * 0);
  }

  createRight(Size size, Path path) {
    path.moveTo(size.width * 1, size.height * 0.2);
    path.lineTo(size.width * 1, size.height * 1);

    path.lineTo(size.width * 0, size.height * 1);

    path.lineTo(size.width * 0, size.height * 0.8);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
