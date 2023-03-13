import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'languages.dart';

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var darkMode = box.read("theme") == null ? false : box.read("theme");
    var langui = box.read("langui") == null
        ? const Locale('en', 'US')
        : box.read("langui") == "fr"
            ? const Locale('fr', 'FR')
            : box.read("langui") == "es"
                ? const Locale('es', 'US')
                : const Locale('en', 'US');

    box.read("favsCountries") ?? box.write("favsCountries", []);

    print(Get.deviceLocale);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: langui,
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      title: "Mundig",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
