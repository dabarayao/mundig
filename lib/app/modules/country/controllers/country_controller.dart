import 'dart:convert';

import 'package:get/get.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

final box = GetStorage();

class CountryController extends GetxController {
  //TODO: Implement CountryController

  var checkInternet = true.obs;
  var favArray = [...box.read('favsCountries')].obs;

  var countryList = fetchCountries(http.Client()).obs;

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
    var rt = str;
    try {
      rt = utf8.decode(str.runes.toList());
    } catch (e) {
      rt = str;
    }

    return rt;
  }

  void increment() => count.value++;
}
