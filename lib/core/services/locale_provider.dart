import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

//   // Switch to Arabic
//   context.setLocale(const Locale('ar'));
//
// // Switch to English
//   context.setLocale(const Locale('en'));
}