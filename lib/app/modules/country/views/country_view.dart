import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/country_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:translator/translator.dart';

final CountryController contCountry = Get.put(CountryController());
late WebViewXController webviewController;

final translator = GoogleTranslator();

class CountryView extends GetView<CountryController> {
  CountryView({Key? key}) : super(key: key);
  var langui = box.read("langui") == null
      ? "en".obs
      : box.read("langui") == "fr"
          ? "fr".obs
          : box.read("langui") == "es"
              ? "es".obs
              : "en".obs;

  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var argCapital = "".obs;

    var listener =
        InternetConnectionCheckerPlus().onStatusChange.listen((status) async {
      switch (status) {
        case InternetConnectionStatus.connected:
          contCountry.checkInternet.value = true;

          webviewController.reload();
          break;
        case InternetConnectionStatus.disconnected:
          contCountry.checkInternet.value = false;
          break;
      }
    });

    args['capital'] != null
        ? Timer.periodic(
            const Duration(seconds: 2),
            (Timer t) => translator
                    .translate(args['capital'][0], from: "en", to: langui.value)
                    .then((s) {
                  argCapital.value = "$s";
                }))
        : "";

    return Scaffold(
      appBar: AppBar(
        title: Text(contCountry.utf(args['countryName'])),
        centerTitle: true,
        backgroundColor: const Color(0xFF63308E),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(color: Color(0xFFF5D797)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.325,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            SizedBox(
                                height: 200,
                                child: CachedNetworkImage(
                                  imageUrl: "${args['flag']}",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const Skeleton(
                                              isLoading: true,
                                              skeleton: SkeletonAvatar(
                                                  style: SkeletonAvatarStyle(
                                                      height: 200, width: 300)),
                                              child: Text("Loading...")),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "pictures/default_country.png",
                                          fit: BoxFit.fill),
                                ) //load image from file
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text(contCountry.utf(args['countryName']),
                            style: const TextStyle(fontSize: 20)),
                        subtitle: Text("Name".tr),
                      ),
                    ),
                  ),
                  args['capital'] != null
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: ListTile(
                                onTap: () {},
                                title: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Obx(
                                    () => Skeleton(
                                      isLoading: argCapital.value != "" ||
                                              langui.value == "en"
                                          ? false
                                          : true,
                                      skeleton: SkeletonLine(
                                          style: SkeletonLineStyle(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width)),
                                      child: Text(
                                          contCountry.utf(langui.value == "en"
                                              ? args['capital'][0]
                                              : argCapital.value),
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                  ),
                                ),
                                subtitle: Text("Capital".tr)),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text(contCountry.utf(args['continent']).tr,
                            style: const TextStyle(fontSize: 20)),
                        subtitle: Text("Continent".tr),
                      ),
                    ),
                  ),
                  args['currency'] != null
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Column(
                              children: [
                                Text(args['currency'].length > 1
                                    ? 'Official currencies'.tr
                                    : 'Official currency'.tr),
                                Column(
                                  children: args['currency']
                                      .entries
                                      .map<Widget>((value) {
                                    var argCurrency = "".obs;

                                    Timer.periodic(
                                        const Duration(seconds: 2),
                                        (Timer t) => translator
                                                .translate(value.value['name'],
                                                    from: 'en',
                                                    to: langui.value)
                                                .then((s) {
                                              argCurrency.value = "$s";
                                            }));

                                    return ListTile(
                                      onTap: () {},
                                      title: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Obx(
                                          () => Skeleton(
                                            isLoading:
                                                argCurrency.value != "" ||
                                                        langui.value == "en"
                                                    ? false
                                                    : true,
                                            skeleton: SkeletonLine(
                                                style: SkeletonLineStyle(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width)),
                                            child: Text(
                                                "${contCountry.utf(langui.value == "en" ? value.value['name'] : argCurrency.value)} (${contCountry.utf(value.value['symbol'])})",
                                                style: const TextStyle(
                                                    fontSize: 20)),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                            "${args['tld'][0]} (www.example${args['tld'][0]} )",
                            style: const TextStyle(fontSize: 20)),
                        subtitle: Text("Top level domain".tr),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text("${args['population']} ${'residents'.tr}",
                            style: const TextStyle(fontSize: 20)),
                        subtitle: Text("Population".tr),
                      ),
                    ),
                  ),
                  args['languages'] != null
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Column(
                              children: [
                                Text(args['languages'].length > 1
                                    ? 'Official languages'.tr
                                    : 'Official language'.tr),
                                Column(
                                  children: args['languages']
                                      .entries
                                      .map<Widget>((value) {
                                    var argLanguage = "".obs;

                                    Timer.periodic(
                                        const Duration(seconds: 2),
                                        (Timer t) => translator
                                                .translate(value.value,
                                                    from: 'en',
                                                    to: langui.value)
                                                .then((s) {
                                              argLanguage.value = "$s";
                                            }));

                                    return ListTile(
                                      onTap: () {},
                                      title: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Obx(
                                          () => Skeleton(
                                            isLoading:
                                                argLanguage.value != "" ||
                                                        langui.value == "en"
                                                    ? false
                                                    : true,
                                            skeleton: SkeletonLine(
                                                style: SkeletonLineStyle(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width)),
                                            child: Text(
                                                "${contCountry.utf(langui.value == "en" ? value.value : argLanguage.value)} (${contCountry.utf(value.key)})",
                                                style: const TextStyle(
                                                    fontSize: 20)),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  args['dialingCode']["root"] != null
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: ListTile(
                              onTap: () {},
                              title: Text(
                                  "${args['dialingCode']['root']}${args['dialingCode']['suffixes'][0]}",
                                  style: const TextStyle(fontSize: 20)),
                              subtitle: Text("Dialing code".tr),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  args['coatOfArms'] != null
                      ? Column(
                          children: [
                            Text("Coat of arms".tr),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                width: 200,
                                child: CachedNetworkImage(
                                  imageUrl: "${args['coatOfArms']}",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const Skeleton(
                                              isLoading: true,
                                              skeleton: SkeletonAvatar(
                                                  style: SkeletonAvatarStyle(
                                                      width: 200, height: 200)),
                                              child: Text("Loading...")),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("pictures/default_arms.png"),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ]),
            Obx(() => contCountry.checkInternet.value == true
                ? WebViewX(
                    initialContent: args['maps'],
                    initialSourceType: SourceType.url,
                    onWebViewCreated: (controller) =>
                        webviewController = controller,
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    onPageFinished: (finish) {
                      //reading response on finish
                    },
                  )
                : Card(
                    color: Colors.red,
                    child: ListTile(
                      textColor: Colors.white,
                      onTap: () {},
                      title: const Text("Check your internet connection",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                      subtitle:
                          Text("Geolocation".tr, textAlign: TextAlign.center),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
