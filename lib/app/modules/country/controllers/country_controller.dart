import 'dart:convert';

import 'package:get/get.dart';

class CountryController extends GetxController {
  //TODO: Implement CountryController

  var checkInternet = true.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  String utf(str) {
    return utf8.decode(str.runes.toList());
  }

  void increment() => count.value++;
}
