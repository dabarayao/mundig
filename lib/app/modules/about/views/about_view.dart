import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(width: 20),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                """Mundig is a software created by the developer Yao Dabara Mickael. 
It displays all country in the world and make it possible to have the main informations about each countries such as the map, the dialing code, the captial...""",
              ),
            ),
            const Text("Developer information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            ListTile(
              onTap: () {
                // add the [https]
                // launchUrl(Uri.parse("tel:+2250779549937")); // new line
                Get.updateLocale(const Locale('fr', 'FR'));
              },
              leading: const Icon(
                Icons.info,
                size: 28,
                color: Color(0xFFF2B538),
              ),
              title: Text("Yao dabara mickael"),
              subtitle: const Text('+2250779549937'),
              trailing: IconButton(
                  icon: const Icon(
                    Icons.mail,
                    color: Color(0xFFF2B538),
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse("mailto:dabarayao@gmail.com"));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
