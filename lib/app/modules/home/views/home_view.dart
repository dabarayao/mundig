import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

import '../controllers/home_controller.dart';

final translator = GoogleTranslator();

final HomeController contHome = Get.put(HomeController());

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: TextField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFDCDCDC),
              suffixIcon: Icon(Icons.search, color: Colors.grey),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide.none),
              hintText: 'Recherche',
            ),
            onChanged: (content) {
              contHome.countryList.value = fetchCountries(http.Client());
              contHome.globalSearch.value = content;
            },
          ),
        ),
        Positioned(
          top: 70,
          left: 0,
          right: 0,
          bottom: 0,
          child: Obx(
            () => FutureBuilder<List<Country>>(
              future: contHome.countryList.value,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return CountriesList(countries: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFB34CF3)),
                  );
                }
              },
            ),
          ),
        ),
      ],
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

class CountriesList extends StatelessWidget {
  CountriesList({super.key, required this.countries});

  List<Country> countries;

  @override
  Widget build(BuildContext context) {
    countries.sort((a, b) => a.name.compareTo(b.name));
    countries.retainWhere((country) => country.name
        .toLowerCase()
        .contains(contHome.globalSearch.value.toLowerCase()));

    return ListView.builder(
      itemCount: countries.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
            leading: Image.network(countries[index].flags as String,
                width: 60, height: 60),
            title: Text("${utf8.decode(countries[index].name.runes.toList())}"),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.remove_red_eye)));
      },
    );
    //  countries[index]
    //         .name
    //         .toLowerCase()
    //         .contains(globalSearch.value.text.toLowerCase()) ;
  }
}
