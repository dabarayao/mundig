import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import './settings.dart';
import './country_list.dart';
import './category_list.dart';
import './country_fav_list.dart';

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
        foregroundColor: Colors.white,
        title: const Text('Mundig'),
        centerTitle: true,
        backgroundColor: const Color(0xFF63308E),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/about");
              },
              icon: const Icon(Icons.info_outline, color: Colors.white))
        ],
      ),
      body: Obx(() => _widgetOptions.elementAt(contHome.selectedIndex.value)),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category),
                label: 'Categories'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: 'Favorites'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'Settings'.tr,
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
