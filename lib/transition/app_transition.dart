import 'package:flutter/material.dart';
import 'list.dart';

class AppTransition {
  static fadeAnimation(Widget widget, BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return widget;
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: curveList[1], parent: animation);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }));
  }

  static rotationAnimation(Widget widget, BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return widget;
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: curveList[1], parent: animation);
          return RotationTransition(
            turns: animation,
            child: child,
          );
        }));
  }

  static scaleAnimation(Widget widget, BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return widget;
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: curveList[1], parent: animation);
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        }));
  }

  static sizeAnimation(Widget widget, BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return widget;
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: curveList[1], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  static slideAnimation(Widget widget, BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return Container();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: curveList[1], parent: animation);
          return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: widget,
          );
        }));
  }
}
