import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:peat/plataform/io.dart'
    if (dart.library.html) 'package:peat/plataform/html.dart';

class Resources {
  static Resources instance;

  static void initialize(TargetPlatform plataforma) {
    switch (plataforma) {
      case TargetPlatform.android:
        Resources.instance = Resources._(PLATFORM == "io" ? "android" : "web");
        break;
      case TargetPlatform.fuchsia:
        Resources.instance = Resources._(PLATFORM == "io" ? "fuchsia" : "web");
        break;
      case TargetPlatform.iOS:
        Resources.instance = Resources._(PLATFORM == "io" ? "ios" : "web");
        break;
      default:
        Resources.instance = Resources._("fuchsia");
        break;
    }
  }

  final String plataforma;

  Resources._(this.plataforma);
}
