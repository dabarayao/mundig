import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var hidImg = box.read("langui") == null
        ? "pictures/english_hidden1_black.png".obs
        : box.read("langui") == "fr"
            ? "pictures/french_hidden1_black.png".obs
            : box.read("langui") == "es"
                ? "pictures/spanish_hidden1_black.png".obs
                : "pictures/english_hidden1_black.png".obs;

    var hidImg2 = box.read("langui") == null
        ? "pictures/english_hidden2_black.png".obs
        : box.read("langui") == "fr"
            ? "pictures/french_hidden2_black.png".obs
            : box.read("langui") == "es"
                ? "pictures/spanish_hidden2_black.png".obs
                : "pictures/english_hidden2_black.png".obs;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('About'.tr),
        centerTitle: true,
        backgroundColor: const Color(0xFF63308E),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("pictures/logo_mundig.png", width: 250)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  """Mundig is a software created by the developer Yao Dabara Mickael. 
It displays all country in the world and make it possible to have the main informations about each countries such as the map, the dialing code, the captial..."""
                      .tr),
            ),
            const SizedBox(height: 10),
            Text("Developer information".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            ListTile(
              onTap: () {
                // add the [https]
                launchUrl(Uri.parse("tel:+2250779549937")); // new line
              },
              leading: const Icon(
                Icons.info,
                size: 28,
                color: Color(0xFFF2B538),
              ),
              title: const Text("Yao dabara mickael"),
              subtitle: const Text('+225 0779549937'),
              trailing: IconButton(
                  icon: const Icon(
                    Icons.mail,
                    color: Color(0xFFF2B538),
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse("mailto:dabarayao@gmail.com"));
                  }),
            ),
            const SizedBox(height: 8),
            Text("Hidden feature".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.10, top: 5),
                child: Text(
                  "Search by dialing code".tr,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Obx(() => Image.asset(hidImg.value,
                  width: MediaQuery.of(context).size.width * 0.80)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.10, top: 5),
                child: Text(
                  "Search by top-level domain".tr,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Obx(() => Image.asset(hidImg2.value,
                  width: MediaQuery.of(context).size.width * 0.80)),
            )
          ],
        ),
      ),
    );
  }
}
