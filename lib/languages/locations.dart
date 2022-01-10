import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Locations {
  Locations(Locale locale) {
    this.locale = locale;
    _values = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _values;

  static Locations of(BuildContext context) {
    return Localizations.of<Locations>(context, Locations);
  }

  String translate(String key) {
    return _values[key];
  }

  static Future<Locations> load(Locale locale) async {
    Locations translations = new Locations(locale);
    String jsonContent =
    await rootBundle.loadString("lang/${locale.languageCode}.json");
    _values = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class LocationsDelegate extends LocalizationsDelegate<Locations> {
  const LocationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'de', 'pl'].contains(locale.languageCode);

  @override
  Future<Locations> load(Locale locale) => Locations.load(locale);

  @override
  bool shouldReload(LocationsDelegate old) => false;
}
