import 'dart:convert';

import 'package:get/get.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

final box = GetStorage();
var sysLng = Platform.localeName.split('_')[0];

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var checkInternet = false.obs;
  var favArray = [...box.read('favsCountries')].obs;

  var darkMode = box.read("theme") != null
      ? box.read("theme")
          ? true.obs
          : false.obs
      : false.obs;

  var langui = box.read("langui") == null
      ? sysLng != "fr" && sysLng != "es"
          ? "en".obs
          : sysLng.obs
      : box.read("langui") == "fr"
          ? "fr".obs
          : box.read("langui") == "es"
              ? "es".obs
              : "en".obs;

  var selectedIndex = 0.obs;
  var globalSearch = "".obs;
  var globalSearchFav = "".obs;
  var globalSearchCategory = "".obs;
  var countryAmericas = "".obs;

  var countryList = fetchCountries(http.Client()).obs;
  var countryCategoryList = fetchCountries(http.Client()).obs;
  var countryFavList = fetchCountries(http.Client()).obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  String utf(str) {
    var rt = str;
    try {
      rt = utf8.decode(str.runes.toList());
    } catch (e) {
      rt = str;
    }

    return rt;
  }

  // int get selectedIndex {
  //   return _selectedIndex;
  // }
}
