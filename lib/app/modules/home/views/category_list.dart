import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:get_storage/get_storage.dart';

final HomeController contHome = Get.put(HomeController());
final box = GetStorage();

class CategoryListView extends GetView<HomeController> {
  CategoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listener =
        InternetConnectionCheckerPlus().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          contHome.checkInternet.value = false;
          fetchCountries(http.Client());
          break;
        case InternetConnectionStatus.disconnected:
          contHome.checkInternet.value = true;
          break;
      }
    });

    return Stack(
      fit: StackFit.expand,
      children: [
        GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: <Widget>[
            InkResponse(
              onTap: () {
                Get.to(() => CountryCategoryView(
                    region: "Americas", title: "Countries of Americas".tr));
              },
              child: GridTile(
                  // header section
                  // ignore: prefer_const_constructors
                  header: GridTileBar(
                      title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Americas'.tr,
                      style: TextStyle(
                        color: contHome.darkMode.value
                            ? Colors.white
                            : Colors.black,
                        backgroundColor: contHome.darkMode.value
                            ? Colors.black.withOpacity(0.5)
                            : null,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                  // footer section
                  footer: GridTileBar(
                    backgroundColor: contHome.darkMode.value
                        ? Colors.black.withOpacity(0.2)
                        : Colors.white.withOpacity(0.7),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: SkeletonLine(
                                  style: SkeletonLineStyle(
                                      width: MediaQuery.of(context).size.width *
                                          0.08)),
                              child: Text('${nbAmericasLove.value}',
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbAmericas.value == 0 ? true : false,
                                skeleton: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08)),
                                child: Text(
                                  "${nbAmericas.value}",
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // main child
                  child: Image.asset("pictures/Americas.png",
                      fit: BoxFit.contain)),
            ),
            InkResponse(
              onTap: () {
                Get.to(() => CountryCategoryView(
                    region: "Europe", title: "Countries of Europe".tr));
              },
              child: GridTile(
                  // header section
                  // ignore: prefer_const_constructors
                  header: GridTileBar(
                      title: Text(
                    'Europe'.tr,
                    style: TextStyle(
                      color:
                          contHome.darkMode.value ? Colors.white : Colors.black,
                      backgroundColor: contHome.darkMode.value
                          ? Colors.black.withOpacity(0.5)
                          : null,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  // footer section
                  footer: GridTileBar(
                    backgroundColor: contHome.darkMode.value
                        ? Colors.black.withOpacity(0.2)
                        : Colors.white.withOpacity(0.7),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: SkeletonLine(
                                  style: SkeletonLineStyle(
                                      width: MediaQuery.of(context).size.width *
                                          0.08)),
                              child: Text('${nbEuropaLove.value}',
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbEurope.value == 0 ? true : false,
                                skeleton: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08)),
                                child: Text(
                                  "${nbEurope.value}",
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // main child
                  child:
                      Image.asset("pictures/Europa.png", fit: BoxFit.contain)),
            ),
            InkResponse(
              onTap: () {
                Get.to(() => CountryCategoryView(
                    region: "Africa", title: "Countries of Africa".tr));
              },
              child: GridTile(
                  // header section
                  // ignore: prefer_const_constructors
                  header: GridTileBar(
                      title: Text(
                    'Africa'.tr,
                    style: TextStyle(
                      color:
                          contHome.darkMode.value ? Colors.white : Colors.black,
                      backgroundColor: contHome.darkMode.value
                          ? Colors.black.withOpacity(0.5)
                          : null,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  // footer section
                  footer: GridTileBar(
                    backgroundColor: contHome.darkMode.value
                        ? Colors.black.withOpacity(0.2)
                        : Colors.white.withOpacity(0.7),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: SkeletonLine(
                                  style: SkeletonLineStyle(
                                      width: MediaQuery.of(context).size.width *
                                          0.08)),
                              child: Text('${nbAfricaLove.value}',
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbAfrica.value == 0 ? true : false,
                                skeleton: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08)),
                                child: Text(
                                  "${nbAfrica.value}",
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // main child
                  child:
                      Image.asset("pictures/Africa.png", fit: BoxFit.contain)),
            ),
            InkResponse(
              onTap: () {
                Get.to(() => CountryCategoryView(
                    region: "Asia", title: "Countries of Asia".tr));
              },
              child: GridTile(
                  // header section
                  // ignore: prefer_const_constructors
                  header: GridTileBar(
                      title: Text(
                    'Asia'.tr,
                    style: TextStyle(
                      color:
                          contHome.darkMode.value ? Colors.white : Colors.black,
                      backgroundColor: contHome.darkMode.value
                          ? Colors.black.withOpacity(0.5)
                          : null,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  // footer section
                  footer: GridTileBar(
                    backgroundColor: contHome.darkMode.value
                        ? Colors.black.withOpacity(0.2)
                        : Colors.white.withOpacity(0.7),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: SkeletonLine(
                                  style: SkeletonLineStyle(
                                      width: MediaQuery.of(context).size.width *
                                          0.08)),
                              child: Text('${nbAsiaLove.value}',
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbAsia.value == 0 ? true : false,
                                skeleton: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08)),
                                child: Text(
                                  "${nbAsia.value}",
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // main child
                  child: Image.asset("pictures/Asie.png", fit: BoxFit.contain)),
            ),
            InkResponse(
              onTap: () {
                Get.to(() => CountryCategoryView(
                    region: "Oceania", title: "Countries of Oceania".tr));
              },
              child: GridTile(
                  // header section
                  // ignore: prefer_const_constructors
                  header: GridTileBar(
                      title: Text(
                    'Oceania'.tr,
                    style: TextStyle(
                      color:
                          contHome.darkMode.value ? Colors.white : Colors.black,
                      backgroundColor: contHome.darkMode.value
                          ? Colors.black.withOpacity(0.5)
                          : null,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  // footer section
                  footer: GridTileBar(
                    backgroundColor: contHome.darkMode.value
                        ? Colors.black.withOpacity(0.2)
                        : Colors.white.withOpacity(0.7),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: SkeletonLine(
                                  style: SkeletonLineStyle(
                                      width: MediaQuery.of(context).size.width *
                                          0.08)),
                              child: Text('${nbOceaniaLove.value}',
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbOceania.value == 0 ? true : false,
                                skeleton: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08)),
                                child: Text(
                                  "${nbOceania.value}",
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // main child
                  child:
                      Image.asset("pictures/Oceania.png", fit: BoxFit.contain)),
            ),
            InkResponse(
              onTap: () {
                Get.to(() => CountryCategoryView(
                    region: "Antarctic", title: "Countries of Antarctic".tr));
              },
              child: GridTile(
                  // header section
                  // ignore: prefer_const_constructors
                  header: GridTileBar(
                      title: Text(
                    'Antarctic'.tr,
                    style: TextStyle(
                      color:
                          contHome.darkMode.value ? Colors.white : Colors.black,
                      backgroundColor: contHome.darkMode.value
                          ? Colors.black.withOpacity(0.5)
                          : null,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  // footer section
                  footer: GridTileBar(
                    backgroundColor: contHome.darkMode.value
                        ? Colors.black.withOpacity(0.2)
                        : Colors.white.withOpacity(0.5),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: SkeletonLine(
                                  style: SkeletonLineStyle(
                                      width: MediaQuery.of(context).size.width *
                                          0.08)),
                              child: Text('${nbAntarcticLove.value}',
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading:
                                    nbAntarctic.value == 0 ? true : false,
                                skeleton: SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08)),
                                child: Text(
                                  "${nbAntarctic.value}",
                                  style: TextStyle(
                                      color: contHome.darkMode.value
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // main child
                  child: Image.asset("pictures/Antarctic.png",
                      fit: BoxFit.contain)),
            ),
          ],
        ),
        Obx(() => Visibility(
              visible: contHome.checkInternet.value,
              child: Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ConnectivityWidget(
                  showOfflineBanner: false,
                  builder: (context, isOnline) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        isOnline
                            ? const SizedBox()
                            : DelayedDisplay(
                                delay: const Duration(seconds: 1),
                                child: Container(
                                  color: Colors.red,
                                  width: double.infinity,
                                  child: const Text(
                                    "Check your internet connection",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class CountryCategoryView extends GetView<HomeController> {
  CountryCategoryView({Key? key, required this.region, required this.title})
      : super(key: key);
  var region;
  var title;

  @override
  Widget build(BuildContext context) {
    contHome.countryCategoryList.value = fetchCountries(http.Client());
    contHome.globalSearchCategory.value = "";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: const Color(0xFF63308E),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFDCDCDC).withOpacity(0.2),
                suffixIcon: const Icon(Icons.search, color: Colors.grey),
                border: const UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none),
                hintText: 'Search'.tr,
              ),
              onChanged: (content) {
                contHome.countryCategoryList.value =
                    fetchCountries(http.Client());
                contHome.globalSearchCategory.value = content;
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
                future: contHome.countryCategoryList.value,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset("pictures/no_internet.png"),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Skeleton(
                          isLoading: true,
                          skeleton: SkeletonListView(
                            scrollable: true,
                            itemBuilder: (context, index) => SkeletonListTile(
                              hasSubtitle: false,
                            ),
                          ),
                          child: const Text("Loading..."));
                    } else {
                      return CountriesCategoryList(
                          countries: snapshot.data!, region: region);
                    }
                  } else {
                    return Skeleton(
                        isLoading: true,
                        skeleton: SkeletonListView(
                          scrollable: true,
                          itemBuilder: (context, index) => SkeletonListTile(
                            hasSubtitle: false,
                            leadingStyle: const SkeletonAvatarStyle(width: 60),
                          ),
                        ),
                        child: const Text("Loading..."));

                    // const Center(
                    //   child: CircularProgressIndicator(color: Color(0xFFB34CF3)),
                    // );
                  }
                },
              ),
            ),
          ),
          Obx(() => Visibility(
                visible: contHome.checkInternet.value,
                child: Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ConnectivityWidget(
                    showOfflineBanner: false,
                    builder: (context, isOnline) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          isOnline
                              ? const SizedBox()
                              : DelayedDisplay(
                                  delay: const Duration(seconds: 1),
                                  child: Container(
                                    color: Colors.red,
                                    width: double.infinity,
                                    child: Text(
                                      "Check your internet connection".tr,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class CountriesCategoryList extends StatelessWidget {
  CountriesCategoryList(
      {super.key, required this.countries, required this.region});

  List<Country> countries;
  var countries2;

  final region;

  @override
  Widget build(BuildContext context) {
    countries.sort((a, b) => (contHome.utf(contHome.langui.value == "en"
            ? a.name
            : contHome.langui.value == "fr"
                ? a.nameFra
                : a.nameSpa))
        .compareTo(contHome.utf(contHome.langui.value == "en"
            ? b.name
            : contHome.langui.value == "fr"
                ? b.nameFra
                : b.nameSpa)));

    countries.retainWhere((country) =>
        (contHome.utf(contHome.langui.value == "en"
                ? country.name
                : contHome.langui.value == "fr"
                    ? country.nameFra
                    : country.nameSpa))
            .toLowerCase()
            .trim()
            .contains(
                contHome.globalSearchCategory.value.toLowerCase().trim()) ||
        country.dialingCode["root"] != null &&
            contHome.globalSearch.value.toLowerCase() ==
                "${country.dialingCode["root"]}${country.dialingCode['suffixes'][0]}");

    countries.retainWhere((country) => country.continent
        .toLowerCase()
        .trim()
        .contains(region.toLowerCase().trim()));

    return countries.length != 0
        ? ListView.builder(
            itemCount: countries.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () => Get.toNamed("/country", arguments: {
                        'countryName': contHome.langui.value == "en"
                            ? countries[index].name
                            : contHome.langui.value == "fr"
                                ? countries[index].nameFra
                                : countries[index].nameSpa,
                        'flag': countries[index].flags,
                        'capital': countries[index].capital,
                        'continent': countries[index].continent,
                        'currency': countries[index].currency,
                        'tld': countries[index].tld,
                        'languages': countries[index].languages,
                        'population': countries[index].population,
                        'coatOfArms': countries[index].coatOfArms,
                        'dialingCode': countries[index].dialingCode,
                        'maps': countries[index].maps
                      }),
                  leading: CachedNetworkImage(
                      imageUrl: countries[index].flags,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => const Skeleton(
                              isLoading: true,
                              skeleton: SkeletonAvatar(
                                  style: SkeletonAvatarStyle(width: 60)),
                              child: Text("Loading...")),
                      errorWidget: (context, url, error) =>
                          Image.asset("pictures/default_country.png"),
                      width: 60,
                      height: 60),
                  title: Text(contHome.utf(contHome.langui.value == "en"
                      ? countries[index].name
                      : contHome.langui.value == "fr"
                          ? countries[index].nameFra
                          : countries[index].nameSpa)),
                  trailing: Obx(
                    () => IconButton(
                        onPressed: () {
                          if (contHome.favArray
                                  .contains(countries[index].name) ==
                              false) {
                            box.write('favsCountries',
                                [...contHome.favArray, countries[index].name]);
                            contHome.favArray.value = [
                              ...box.read('favsCountries')
                            ];
                          } else {
                            var favs = box.read('favsCountries');
                            favs.removeWhere(
                                (item) => item == countries[index].name);
                            box.write('favsCountries', [...favs]);
                            contHome.favArray.value = [
                              ...box.read('favsCountries')
                            ];
                          }
                          contHome.countryList.value =
                              fetchCountries(http.Client());
                        },
                        icon: contHome.favArray.contains(countries[index].name)
                            ? const Icon(Icons.favorite,
                                color: Color(0xFFF2B538))
                            : const Icon(Icons.favorite_border)),
                  ));
            },
          )
        : Center(child: Image.asset("pictures/no_result_en.png"));

    //  countries[index]
    //         .name
    //         .toLowerCase()
    //         .contains(globalSearchCategory.value.text.toLowerCase()) ;
  }
}
