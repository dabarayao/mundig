import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../controllers/home_controller.dart';
import './settings.dart';
import './country_list.dart';
import './category_list.dart';
import './country_fav_list.dart';

final translator = GoogleTranslator();

final HomeController contHome = Get.put(HomeController());

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    CountryListView(),
    CategoryListView(),
    CountryFavListView(),
    SettingsView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mundig'),
        centerTitle: true,
        backgroundColor: const Color(0xFF63308E),
        actions: [
          IconButton(
              onPressed: () {
                // if (Get.isDarkMode) {
                //   Get.changeTheme(ThemeData.light());
                //   contHome.darkMode.value = false;
                // } else {
                //   Get.changeTheme(ThemeData.dark());
                //   contHome.darkMode.value = true;
                // }
              },
              icon: const Icon(Icons.info_outline, color: Colors.white)
              // Icon(
              // contHome.darkMode.value
              //     ? Icons.brightness_4
              //     : Icons.brightness_3,
              // color: Colors.white),
              )
        ],
      ),
      body: Obx(() => _widgetOptions.elementAt(contHome.selectedIndex.value)),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Catégories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favoris',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Paramètres',
              ),
            ],
            currentIndex: contHome.selectedIndex.value,
            selectedItemColor: contHome.darkMode.value
                ? const Color(0xFFb19cd9)
                : const Color(0xFF63308E),
            unselectedItemColor: Colors.grey,
            onTap: contHome.onItemTapped,
          )),
    );
  }
}
