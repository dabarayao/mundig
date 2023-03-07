import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../controllers/home_controller.dart';
import 'package:share_plus/share_plus.dart';

final translator = GoogleTranslator();

final HomeController contHome = Get.put(HomeController());

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
                          "Choose a language",
                        ),
                        children: [
                          RadioListTile(
                            activeColor: Color(0xFFF2B538),
                            title: Text(
                              "French",
                            ),
                            value: "fr",
                            groupValue: "fr",
                            onChanged: (value) {
                              box.write("langui", "fr");
                              Navigator.pop(context);
                            },
                          ),
                          RadioListTile(
                            activeColor: Color(0xFFF2B538),
                            title: Text("English"),
                            value: "en",
                            groupValue: "fr",
                            onChanged: (value) {
                              box.write("langui", "en");
                              Navigator.pop(context);
                            },
                          ),
                          RadioListTile(
                            activeColor: Color(0xFFF2B538),
                            title: Text("Spanish"),
                            value: "en",
                            groupValue: "fr",
                            onChanged: (value) {
                              box.write("langui", "en");
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    }));
          },
          leading: Icon(Icons.language),
          title: Text('Language'),
        ),
        ListTile(
            onTap: () {},
            leading: Icon(Icons.color_lens_outlined),
            title: Text('Dark theme'),
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
                activeColor: Color(0xFFF2B538),
                onChanged: (value) {
                  if (Get.isDarkMode) {
                    box.write("theme", false);
                    Get.changeTheme(ThemeData.light());
                    contHome.darkMode.value = false;
                  } else {
                    box.write("theme", true);
                    Get.changeTheme(ThemeData.dark());
                    contHome.darkMode.value = true;
                  }
                },
              ),
            )),
        ListTile(
          onTap: () {
            Share.share(
              subject: "Contactup - Enregistrer et suivez vos contacts",
              "https://drive.google.com/file/d/14PYIXEOjtdc8pdJNub8XmE1q_0d0pTrN/view?usp=share_link",
            );
          },
          leading: Icon(
            Icons.share_outlined,
          ),
          title: Text("Share the app"),
        ),
      ],
    );
  }
}
