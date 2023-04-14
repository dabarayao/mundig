import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final box = GetStorage();
var nbAmericas = 0.obs;
var nbAmericasLove = 0.obs;
var nbEurope = 0.obs;
var nbEuropaLove = 0.obs;
var nbAfrica = 0.obs;
var nbAfricaLove = 0.obs;
var nbAsia = 0.obs;
var nbAsiaLove = 0.obs;
var nbOceania = 0.obs;
var nbOceaniaLove = 0.obs;
var nbAntarctic = 0.obs;
var nbAntarcticLove = 0.obs;

var languiData = box.read("langui") == null
    ? "en".obs
    : box.read("langui") == "fr"
        ? "fr".obs
        : box.read("langui") == "es"
            ? "es".obs
            : "en".obs;

var suggestion = [].obs;
var suggestionAmericas = [].obs;
var suggestionEurope = [].obs;
var suggestionAfrica = [].obs;
var suggestionAsia = [].obs;
var suggestionOceania = [].obs;
var suggestionAntarctic = [].obs;

String utf(str) {
  var rt = str;
  try {
    rt = utf8.decode(str.runes.toList());
  } catch (e) {
    rt = str;
  }

  return rt;
}

Future<List<Country>> fetchCountries(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://restcountries.com/v3.1/all'));

  // Use the compute function to run parseCountrys in a separate isolate.
  var tray = jsonDecode(response.body).toList();

  tray.sort((a, b) => (utf(languiData.value == "en"
          ? a['name']['common']
          : languiData.value == "fr"
              ? a['translations']['fra']['common']
              : a['translations']['spa']['common']))
      .compareTo(utf(languiData.value == "en"
          ? b['name']['common']
          : languiData.value == "fr"
              ? b['translations']['fra']['common']
              : b['translations']['spa']['common'])));

  countCountry(val) =>
      tray.where((row) => (row["region"].toLowerCase() == val)).length;

  countCountryLove(val) => tray
      .where((row) => (row["region"].toLowerCase() == val &&
          box.read("favsCountries").contains(row['name']['common'])))
      .length;

  // for (var i = 0; i < tray.length; i++) {
  //   if (tray[i]["region"].toLowerCase() == "americas") {
  //     nbAmericas++;
  //   }
  // }
  nbAmericas.value = countCountry("americas");
  nbEurope.value = countCountry("europe");
  nbAfrica.value = countCountry("africa");
  nbAsia.value = countCountry("asia");
  nbOceania.value = countCountry("oceania");
  nbAntarctic.value = countCountry("antarctic");

  nbAmericasLove.value = countCountryLove("americas");
  nbEuropaLove.value = countCountryLove("europe");
  nbAfricaLove.value = countCountryLove("africa");
  nbAsiaLove.value = countCountryLove("asia");
  nbOceaniaLove.value = countCountryLove("oceania");
  nbAntarcticLove.value = countCountryLove("antarctic");

  // Global suggestion

  suggester(val) {
    for (var country in tray) {
      if (val != "" && val != country["region"].toLowerCase()) {
        continue;
      }

      (val == "americas"
              ? suggestionAmericas
              : val == "europe"
                  ? suggestionEurope
                  : val == "africa"
                      ? suggestionAfrica
                      : val == "asia"
                          ? suggestionAsia
                          : val == "oceania"
                              ? suggestionOceania
                              : val == "antarctic"
                                  ? suggestionAntarctic
                                  : suggestion)
          .add(
        languiData.value == "en"
            ? utf(country['name']['common'])
            : languiData.value == "fr"
                ? utf(country['translations']['fra']['common'])
                : utf(country['translations']['spa']['common']),
      );
    }

    for (var country in tray) {
      if (val != "" && val != country["region"].toLowerCase()) {
        continue;
      }
      country['idd']["root"] != null
          ? (val == "americas"
                  ? suggestionAmericas
                  : val == "europe"
                      ? suggestionEurope
                      : val == "africa"
                          ? suggestionAfrica
                          : val == "asia"
                              ? suggestionAsia
                              : val == "oceania"
                                  ? suggestionOceania
                                  : val == "antarctic"
                                      ? suggestionAntarctic
                                      : suggestion)
              .add("${country['idd']['root']}${country['idd']['suffixes'][0]}")
          : "";
    }

    for (var country in tray) {
      if (val != "" && val != country["region"].toLowerCase()) {
        continue;
      }
      country['tld'] != null
          ? (val == "americas"
                  ? suggestionAmericas
                  : val == "europe"
                      ? suggestionEurope
                      : val == "africa"
                          ? suggestionAfrica
                          : val == "asia"
                              ? suggestionAsia
                              : val == "oceania"
                                  ? suggestionOceania
                                  : val == "antarctic"
                                      ? suggestionAntarctic
                                      : suggestion)
              .add(country['tld'][0])
          : "";
    }
  }

  //Americas suggestion
  suggestion.clear();
  suggestionAmericas.clear();
  suggestionEurope.clear();
  suggestionAfrica.clear();
  suggestionAsia.clear();
  suggestionOceania.clear();
  suggestionAntarctic.clear();

  suggester("");
  suggester("americas");
  suggester("africa");
  suggester("asia");
  suggester("oceania");
  suggester("antarctic");
  suggester("favs");

  print(box.read('favsCountries'));

  return compute(parseCountries, response.body);
}

// A function that converts a response body into a List<Country>.
List<Country> parseCountries(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Country>((json) => Country.fromJson(json)).toList();
}

class Country {
  final String name;
  final String nameFra;
  final String nameSpa;
  final String flags;
  final capital;
  final String continent;
  final currency;
  final tld;
  final languages;
  final population;
  final coatOfArms;
  final dialingCode;
  final maps;

  const Country({
    required this.flags,
    required this.nameFra,
    required this.nameSpa,
    required this.name,
    required this.capital,
    required this.continent,
    required this.currency,
    required this.tld,
    required this.languages,
    required this.population,
    required this.coatOfArms,
    required this.dialingCode,
    required this.maps,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      nameFra: json['translations']['fra']['common'] as String,
      nameSpa: json['translations']['spa']['common'] as String,
      flags: json['flags']['png'] as String,
      capital: json['capital'],
      continent: json['region'] as String,
      currency: json['currencies'],
      tld: json['tld'],
      languages: json['languages'],
      population: json['population'],
      coatOfArms: json['coatOfArms']["png"],
      dialingCode: json['idd'],
      maps: json['maps']["googleMaps"],
    );
  }
}
