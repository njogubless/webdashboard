part of webdashboard_utils;

class WDValues {
  WDValues({
    required this.urlScheme,
    required this.baseDomain,
    required this.hiveDBKey,
  });

  final String urlScheme;
  final String hiveDBKey;
  final String baseDomain;
}

class WDConfig {
  factory WDConfig({required WDValues values}) {
    return _instance ??= WDConfig._internal(values);
  }

  WDConfig._internal(this.values);

  final WDValues values;
  static WDConfig? _instance;

  static WDConfig? get instance => _instance;
}
