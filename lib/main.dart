import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();

  final box = GetStorage();
  var darkMode = box.read("theme");
  box.read("favsCountries") ??  box.write("favsCountries", []);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      title: "Mundig",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
