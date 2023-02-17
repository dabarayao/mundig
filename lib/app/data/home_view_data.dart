import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> fetchCountries(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://restcountries.com/v3.1/all'));

  // Use the compute function to run parseCountrys in a separate isolate.
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
