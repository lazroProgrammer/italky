import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale? locale;
  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate= _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future loadJsonLanguage() async {
    try{
    String json =
        await rootBundle.loadString('assets/lang/${locale!.languageCode}.json');

    Map<String, dynamic> jsonMap = jsonDecode(json);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    }catch(e){
      print('error loading the file ${e}');
      rethrow;
    }
  }
  String translate(String key) => _localizedStrings[key] ?? '';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization>{

  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','ar','fr'].contains(locale.countryCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async{

    AppLocalization localization=AppLocalization(locale);

    await localization.loadJsonLanguage();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old)=>false;
}