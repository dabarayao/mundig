import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'dart:io';
import 'languages.dart';

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var sysLng = Platform.localeName.split('_')[0];

    var darkMode = box.read("theme") != null
        ? box.read("theme")
            ? true.obs
            : false.obs
        : false.obs;
    var langui = box.read("langui") == null
        ? (sysLng == "fr"
            ? const Locale('fr', 'FR')
            : sysLng == "es"
                ? const Locale('es', 'US')
                : const Locale('en', 'US'))
        : box.read("langui") == "fr"
            ? const Locale('fr', 'FR')
            : box.read("langui") == "es"
                ? const Locale('es', 'US')
                : const Locale('en', 'US');

    box.read("favsCountries") ?? box.write("favsCountries", []);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: langui,
      theme: darkMode.value == true ? ThemeData.dark() : ThemeData.light(),
      title: "Mundig",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
