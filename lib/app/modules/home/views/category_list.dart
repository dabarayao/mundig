import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mundig/app/modules/home/views/country_list.dart';
import '../controllers/home_controller.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stroke_text/stroke_text.dart';

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
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
          contHome.checkInternet.value = true;
          print('You are disconnected from the internet.');
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
                        : Colors.white.withOpacity(0.5),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Expanded(
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: const SkeletonLine(
                                  style: SkeletonLineStyle()),
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
                        Obx(() => Expanded(
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbAmericas.value == 0 ? true : false,
                                skeleton: const SkeletonLine(
                                    style: SkeletonLineStyle()),
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
                        : Colors.white.withOpacity(0.5),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Expanded(
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: const SkeletonLine(
                                  style: SkeletonLineStyle()),
                              child: Expanded(
                                child: Text('${nbEuropaLove.value}',
                                    style: TextStyle(
                                        color: contHome.darkMode.value
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Expanded(
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbEurope.value == 0 ? true : false,
                                skeleton: const SkeletonLine(
                                    style: SkeletonLineStyle()),
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
                        : Colors.white.withOpacity(0.5),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Expanded(
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: const SkeletonLine(
                                  style: SkeletonLineStyle()),
                              child: Expanded(
                                child: Text('${nbAfricaLove.value}',
                                    style: TextStyle(
                                        color: contHome.darkMode.value
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Expanded(
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbAfrica.value == 0 ? true : false,
                                skeleton: const SkeletonLine(
                                    style: SkeletonLineStyle()),
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
                        : Colors.white.withOpacity(0.5),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Expanded(
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: const SkeletonLine(
                                  style: SkeletonLineStyle()),
                              child: Expanded(
                                child: Text('${nbAsiaLove.value}',
                                    style: TextStyle(
                                        color: contHome.darkMode.value
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Expanded(
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbAsia.value == 0 ? true : false,
                                skeleton: const SkeletonLine(
                                    style: SkeletonLineStyle()),
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
                        : Colors.white.withOpacity(0.5),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        Obx(
                          () => Expanded(
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: const SkeletonLine(
                                  style: SkeletonLineStyle()),
                              child: Expanded(
                                child: Text('${nbOceaniaLove.value}',
                                    style: TextStyle(
                                        color: contHome.darkMode.value
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Expanded(
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading: nbOceania.value == 0 ? true : false,
                                skeleton: const SkeletonLine(
                                    style: SkeletonLineStyle()),
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
                          () => Expanded(
                            child: Skeleton(
                              themeMode: contHome.darkMode.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                              isLoading: nbAmericas.value == 0 ? true : false,
                              skeleton: const SkeletonLine(
                                  style: SkeletonLineStyle()),
                              child: Expanded(
                                child: Text('${nbAntarcticLove.value}',
                                    style: TextStyle(
                                        color: contHome.darkMode.value
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const FaIcon(FontAwesomeIcons.earthAfrica,
                            color: Colors.grey),
                        Obx(() => Expanded(
                              child: Skeleton(
                                themeMode: contHome.darkMode.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                isLoading:
                                    nbAntarctic.value == 0 ? true : false,
                                skeleton: const SkeletonLine(
                                    style: SkeletonLineStyle()),
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
                            ? SizedBox()
                            : TranslationAnimatedWidget(
                                enabled:
                                    true, //update this boolean to forward/reverse the animation
                                values: const [
                                  Offset(0, 200), // disabled value value
                                  Offset(0, 250), //intermediate value
                                  Offset(0, 0) //enabled value
                                ],
                                child: Container(
                                  color: Colors.red,
                                  width: double.infinity,
                                  child: const Text(
                                    "Vérifier votre connexion internet",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ) /* your widget */
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
                fillColor: Color(0xFFDCDCDC).withOpacity(0.2),
                suffixIcon: Icon(Icons.search, color: Colors.grey),
                border: UnderlineInputBorder(
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
                      child: Expanded(
                          child: Image.asset("pictures/no_internet.png")),
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
                              ? SizedBox()
                              : TranslationAnimatedWidget(
                                  enabled:
                                      true, //update this boolean to forward/reverse the animation
                                  values: const [
                                    Offset(0, 200), // disabled value value
                                    Offset(0, 250), //intermediate value
                                    Offset(0, 0) //enabled value
                                  ],
                                  child: Container(
                                    color: Colors.red,
                                    width: double.infinity,
                                    child: const Text(
                                      "Vérifier votre connexion internet",
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ) /* your widget */
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
    countries.sort((a, b) => a.name.compareTo(b.name));

    countries.retainWhere((country) =>
        country.name.toLowerCase().trim().contains(
            contHome.globalSearchCategory.value.toLowerCase().trim()) ||
        country.dialingCode["root"] != null &&
            "${country.dialingCode["root"]}${country.dialingCode['suffixes'][0]}"
                .contains(
                    contHome.globalSearchCategory.value.toLowerCase().trim()));

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
                        'countryName': countries[index].name,
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
                  title: Text(contHome.utf(countries[index].name)),
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
                            ? Icon(Icons.favorite, color: Color(0xFFF2B538))
                            : Icon(Icons.favorite_border)),
                  ));
            },
          )
        : Center(
            child: Expanded(child: Image.asset("pictures/no_result_en.png")));

    //  countries[index]
    //         .name
    //         .toLowerCase()
    //         .contains(globalSearchCategory.value.text.toLowerCase()) ;
  }
}
