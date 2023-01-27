import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://restcountries.com/v3.1/all'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String name;
  final String nameFra;
  final String nameSpa;
  final String flags;

  const Photo(
      {required this.flags,
      required this.nameFra,
      required this.nameSpa,
      required this.name});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      name: json['name']['common'],
      nameFra: json['translations']['fra']['common'] as String,
      nameSpa: json['translations']['spa']['common'] as String,
      flags: json['flags']['png'] as String,
    );
  }
}
