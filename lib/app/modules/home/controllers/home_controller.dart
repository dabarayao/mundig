import 'dart:convert';

import 'package:get/get.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final box = GetStorage();

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // Padding(
  //         padding: EdgeInsets.all(15.0),
  //         child: TextField(
  //           controller: contHome.globalSearch.value,
  //           decoration: const InputDecoration(
  //             filled: true,
  //             fillColor: Color(0xFFDCDCDC),
  //             suffixIcon: Icon(Icons.search, color: Colors.grey),
  //             border: UnderlineInputBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
  //                 borderSide: BorderSide.none),
  //             hintText: 'Recherche',
  //           ),
  //         ),
  //       ),

  var checkInternet = false.obs;
  var favArray = [...box.read('favsCountries')].obs;

  var darkMode = box.read("theme") ? true.obs : false.obs;
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
    return utf8.decode(str.runes.toList());
  }

  // int get selectedIndex {
  //   return _selectedIndex;
  // }
}
