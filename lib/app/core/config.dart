enum Flavor {
  development,
  staging,
  production,
}

class Config {
  static Flavor appFlavor = Flavor.development;

  static bool get debugShowCheckedModeBanner {
    switch (appFlavor) {
      case Flavor.development:
        return true;
      case Flavor.staging:
        return false;
      case Flavor.production:
        return false;
    }
  }

  static String get versionMessage {
    switch (appFlavor) {
      case Flavor.development:
        return 'Developers version';
      case Flavor.staging:
        return 'Test version';
      case Flavor.production:
        return '';
    }
  }
}
