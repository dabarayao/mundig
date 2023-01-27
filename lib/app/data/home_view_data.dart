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

  const Country(
      {required this.flags,
      required this.nameFra,
      required this.nameSpa,
      required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      nameFra: json['translations']['fra']['common'] as String,
      nameSpa: json['translations']['spa']['common'] as String,
      flags: json['flags']['png'] as String,
    );
  }
}
