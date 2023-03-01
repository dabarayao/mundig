import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/country_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final CountryController contCountry = Get.put(CountryController());
late WebViewXController webviewController;

class CountryView extends GetView<CountryController> {
  CountryView({Key? key}) : super(key: key);

  var args = Get.arguments;
  var listener =
      InternetConnectionCheckerPlus().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        contCountry.checkInternet.value = true;
        webviewController.reload();
        print('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        contCountry.checkInternet.value = false;
        print('You are disconnected from the internet.');
        break;
    }
  });

  @override
  Widget build(BuildContext context) {
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
                    decoration: BoxDecoration(
                        color: const Color(0xFFF2B538).withOpacity(0.5)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.325,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
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
                                                      width: 60)),
                                              child: Text("Loading...")),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.person_outline,
                                          size: 160, color: Color(0XFF1F1F30)),
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
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text("Name"),
                      ),
                    ),
                  ),
                  args['capital'] != null
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: ListTile(
                                onTap: () {},
                                title:
                                    Text(contCountry.utf(args['capital'][0])),
                                subtitle: Text("Capital")),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text(contCountry.utf(args['continent']),
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text("Continent"),
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
                                    ? 'Official currencies'
                                    : 'Official currency'),
                                Column(
                                  children: args['currency']
                                      .entries
                                      .map<Widget>((value) => ListTile(
                                            onTap: () {},
                                            title: Text(
                                                "${contCountry.utf(value.value['name'])} (${contCountry.utf(value.value['symbol'])})",
                                                style: TextStyle(fontSize: 20)),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                            "${args['tld'][0]} (www.example${args['tld'][0]} )",
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text("Top level domain"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text("${args['population']} residents",
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text("Population"),
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
                                    ? 'Official languages'
                                    : 'Official language'),
                                Column(
                                  children: args['languages']
                                      .entries
                                      .map<Widget>((value) => ListTile(
                                            onTap: () {},
                                            title: Text(
                                                "${contCountry.utf(value.value)} (${contCountry.utf(value.key)})",
                                                style: TextStyle(fontSize: 20)),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  args['coatOfArms'] != null
                      ? Column(
                          children: [
                            Text("Coat of arms"),
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
                                      const Icon(Icons.person_outline,
                                          size: 160, color: Color(0XFF1F1F30)),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  args['dialingCode']["root"] != null
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: ListTile(
                              onTap: () {},
                              title: Text(
                                  "${args['dialingCode']['root']}${args['dialingCode']['suffixes'][0]}",
                                  style: TextStyle(fontSize: 20)),
                              subtitle: Text("Dialing code"),
                            ),
                          ),
                        )
                      : SizedBox(),
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
                      print("finish is ${finish}");
                    },
                  )
                : Card(
                    color: Colors.red,
                    child: ListTile(
                      textColor: Colors.white,
                      onTap: () {},
                      title: const Text("Vérifier votre connexion internet",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                      subtitle:
                          Text("Géolocalisation", textAlign: TextAlign.center),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
