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

Future<List<Country>> fetchCountries(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://restcountries.com/v3.1/all'));

  // Use the compute function to run parseCountrys in a separate isolate.
  var tray = jsonDecode(response.body).toList();

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
