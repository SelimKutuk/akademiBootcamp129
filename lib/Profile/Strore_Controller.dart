import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller_Sayfasi extends GetxController {
  var sayi = 0.obs;

  void increment() {
    sayi++;
  }
}
