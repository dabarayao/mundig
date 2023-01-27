import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

import '../controllers/home_controller.dart';

final translator = GoogleTranslator();

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final HomeController contHome = Get.put(HomeController());

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    FutureBuilder<List<Photo>>(
      future: fetchPhotos(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return PhotosList(photos: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
    const Center(
      child: Text(
        'Index 1: Business',
        style: optionStyle,
      ),
    ),
    const Center(
      child: Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ),
    const Center(
      child: Text(
        'Index 3: School',
        style: optionStyle,
      ),
    ),
    Center(
      child: ElevatedButton(
          onPressed: () async {
            var translation = await translator.translate("Moscow!", to: 'es');
            print(translation);
          },
          child: Text("dzd")),
    ),
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
                if (Get.isDarkMode) {
                  Get.changeTheme(ThemeData.light());
                  contHome.darkMode.value = false;
                } else {
                  Get.changeTheme(ThemeData.dark());
                  contHome.darkMode.value = true;
                }
              },
              icon: Obx(
                () => Icon(
                    contHome.darkMode.value
                        ? Icons.brightness_4
                        : Icons.brightness_3,
                    color: Colors.white),
              ))
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
                icon: Icon(Icons.info),
                label: 'A propos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Paramètres',
              ),
            ],
            currentIndex: contHome.selectedIndex.value,
            selectedItemColor: const Color(0xFF63308E),
            unselectedItemColor: Colors.grey,
            onTap: contHome.onItemTapped,
          )),
    );
  }
}

class PhotosList extends StatelessWidget {
  PhotosList({super.key, required this.photos});

  List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    photos.sort((a, b) => a.name.compareTo(b.name));

    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: Image.network(photos[index].flags as String,
                width: 60, height: 60),
            title: Text("${utf8.decode(photos[index].name.runes.toList())}"),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.remove_red_eye)));
      },
    );
  }
}
