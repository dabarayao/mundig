import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:mundig/app/data/home_view_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:get_storage/get_storage.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:http/http.dart' as http;

final HomeController contHome = Get.put(HomeController());
final box = GetStorage();

class CountryFavListView extends GetView<HomeController> {
  CountryFavListView({Key? key}) : super(key: key);
  var i = 0;

  @override
  Widget build(BuildContext context) {
    var listener =
        InternetConnectionCheckerPlus().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          contHome.checkInternet.value = false;
          contHome.countryFavList.value = fetchCountries(http.Client());
          break;
        case InternetConnectionStatus.disconnected:
          contHome.checkInternet.value = true;
          break;
      }
    });

    contHome.countryFavList.value = fetchCountries(http.Client());

    box.listenKey('favsCountries', (value) {
      contHome.countryFavList.value = fetchCountries(http.Client());
    });

    return Stack(
      fit: StackFit.expand,
      children: [
        Visibility(
          visible: contHome.favArray.length != 0 ? true : false,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(() => EasyAutocomplete(
                  controller: TextEditingController(
                      text: contHome.globalSearchFav.value),
                  suggestions: suggestion.toList().cast<String>(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFDCDCDC).withOpacity(0.2),
                    suffixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide.none),
                    hintText: 'Search'.tr,
                  ),
                  onChanged: (value) {
                    contHome.countryFavList.value =
                        fetchCountries(http.Client());
                    contHome.globalSearchFav.value = value;
                  },
                )),
          ),
        ),
        Obx(
          () => Positioned(
            top: contHome.favArray.isNotEmpty ? 70 : 0,
            left: 0,
            right: 0,
            bottom: contHome.checkInternet.value ? 15 : 0,
            child: FutureBuilder<List<Country>>(
              future: contHome.countryFavList.value,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Obx(() => contHome.checkInternet.value == false
                      ? Skeleton(
                          isLoading: true,
                          skeleton: SkeletonListView(
                            scrollable: true,
                            itemBuilder: (context, index) => SkeletonListTile(
                              hasSubtitle: false,
                              leadingStyle:
                                  const SkeletonAvatarStyle(width: 60),
                            ),
                          ),
                          child: const Text("Loading..."))
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset("pictures/no_internet.png"),
                        ));
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
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
                  } else {
                    return CountriesFavList(countries: snapshot.data!);
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
              child: Padding(
                  padding: const EdgeInsets.all(0),
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
                  )),
            )))
      ],
    );
  }
}

class CountriesFavList extends StatelessWidget {
  CountriesFavList({super.key, required this.countries});

  List<Country> countries;

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
            .contains(contHome.globalSearchFav.value.toLowerCase().trim()) ||
        country.dialingCode["root"] != null &&
            contHome.globalSearchFav.value.toLowerCase().trim() ==
                "${country.dialingCode["root"]}${country.dialingCode['suffixes'][0]}" ||
        country.tld != null &&
            contHome.globalSearchFav.value.toLowerCase().trim() ==
                country.tld[0].toLowerCase().trim());

    countries.retainWhere(
        (country) => box.read('favsCountries').contains(country.name));

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
                  trailing: IconButton(
                      onPressed: () {
                        var favs = box.read('favsCountries');
                        favs.removeWhere(
                            (item) => item == countries[index].name);
                        box.write('favsCountries', [...favs]);
                        contHome.favArray.value = [
                          ...box.read('favsCountries')
                        ];
                        contHome.countryFavList.value =
                            fetchCountries(http.Client());
                      },
                      icon: const Icon(Icons.favorite,
                          color: Color(0xFFF2B538))));
            },
          )
        : Obx(
            () => Center(
                child: contHome.langui.value == "fr"
                    ? Image.asset("pictures/no_result_fr.png")
                    : contHome.langui.value == "es"
                        ? Image.asset("pictures/no_result_es.png")
                        : Image.asset("pictures/no_result_en.png")),
          );

    //  countries[index]
    //         .name
    //         .toLowerCase()
    //         .contains(globalSearch.value.text.toLowerCase()) ;
  }
}
