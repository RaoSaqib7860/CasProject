import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  static MyController get to => Get.find<MyController>();
  bool isConectionStarted = false;
  PageController pageController = PageController();
}
