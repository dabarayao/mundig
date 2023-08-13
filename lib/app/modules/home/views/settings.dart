import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../controllers/home_controller.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:get_storage/get_storage.dart';

import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:country_flags/country_flags.dart';

final translator = GoogleTranslator();

final HomeController contHome = Get.put(HomeController());
final box = GetStorage();

class SettingsView extends GetView<HomeController> {
  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    StatefulBuilder(builder: (context, StateSetter setState) {
                      return SimpleDialog(
                        title: Text(
                          "Choose a language".tr,
                        ),
                        children: [
                          Obx(
                            () => RadioListTile(
                              activeColor: const Color(0xFFF2B538),
                              title: Row(
                                children: [
                                  CountryFlag.fromCountryCode(
                                    'us',
                                    height: 25,
                                    width: 25,
                                    borderRadius: 0,
                                  ),
                                  const SizedBox(width: 5),
                                  Text("English".tr),
                                ],
                              ),
                              value: "en",
                              groupValue: contHome.langui.value,
                              onChanged: (value) {
                                box.write("langui", "en");
                                contHome.langui.value = "en";
                                languiData.value = "en";
                                Get.updateLocale(const Locale('en', 'US'));
                                contHome.countryList.value =
                                    fetchCountries(http.Client());
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Obx(() => RadioListTile(
                              activeColor: const Color(0xFFF2B538),
                              title: Row(
                                children: [
                                  CountryFlag.fromCountryCode(
                                    'fr',
                                    height: 25,
                                    width: 25,
                                    borderRadius: 0,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "French".tr,
                                  ),
                                ],
                              ),
                              value: "fr",
                              groupValue: contHome.langui.value,
                              onChanged: (value) {
                                box.write("langui", "fr");
                                contHome.langui.value = "fr";
                                languiData.value = "fr";
                                Get.updateLocale(const Locale('fr', 'FR'));
                                contHome.countryList.value =
                                    fetchCountries(http.Client());
                                Navigator.pop(context);
                              })),
                          Obx(() => RadioListTile(
                                activeColor: const Color(0xFFF2B538),
                                title: Row(
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      'es',
                                      height: 25,
                                      width: 25,
                                      borderRadius: 0,
                                    ),
                                    const SizedBox(width: 5),
                                    Text("Spanish".tr),
                                  ],
                                ),
                                value: "es",
                                groupValue: contHome.langui.value,
                                onChanged: (value) {
                                  box.write("langui", "es");
                                  contHome.langui.value = "es";
                                  languiData.value = "es";
                                  Get.updateLocale(const Locale('es', 'US'));
                                  contHome.countryList.value =
                                      fetchCountries(http.Client());
                                  Navigator.pop(context);
                                },
                              ))
                        ],
                      );
                    }));
          },
          leading: const Icon(Icons.language),
          title: Text('Languages'.tr),
        ),
        ListTile(
            onTap: () async {
              if (Get.isDarkMode) {
                box.write("theme", false);
                Get.changeTheme(ThemeData.light());
                contHome.darkMode.value = false;
                await Get.forceAppUpdate();
              } else {
                box.write("theme", true);
                Get.changeTheme(ThemeData.dark());
                contHome.darkMode.value = true;
                await Get.forceAppUpdate();
              }
            },
            leading: const Icon(Icons.color_lens_outlined),
            title: Text('Dark theme'.tr),
            trailing:
                // IconButton(
                //     onPressed: () {
                //       _changeTheme();
                //     },
                //     icon: _darkTheme
                //         ? Icon(Icons.toggle_on,
                //             size: 35, color: Color(0xFFF2B538))
                //         : Icon(Icons.toggle_off, size: 35)),
                Obx(
              () => Switch(
                value: contHome.darkMode.value,
                activeColor: const Color(0xFFF2B538),
                onChanged: (value) async {
                  if (Get.isDarkMode) {
                    box.write("theme", false);
                    Get.changeTheme(ThemeData.light());
                    contHome.darkMode.value = false;
                    await Get.forceAppUpdate();
                  } else {
                    box.write("theme", true);
                    Get.changeTheme(ThemeData.dark());
                    contHome.darkMode.value = true;
                    await Get.forceAppUpdate();
                  }
                },
              ),
            )),
        ListTile(
          onTap: () {
            Share.share(
              """${"Mundig - Travel without move".tr} :
https://drive.google.com/drive/folders/1TzK3KVLNjSReEmJaYOePnGf8wMkbaref?usp=share_link""",
            );
          },
          leading: const Icon(
            Icons.share_outlined,
          ),
          title: Text("Share the app".tr),
        ),
      ],
    );
  }
}
