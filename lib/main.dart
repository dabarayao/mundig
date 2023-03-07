import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'languages.dart';

void main() async {
  await GetStorage.init();

  final box = GetStorage();
  var darkMode = box.read("theme");
  box.read("favsCountries") ?? box.write("favsCountries", []);

  print(Get.deviceLocale);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('fr', 'FR'),
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      title: "Mundig",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
