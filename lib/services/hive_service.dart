part of webdashboard_services;

abstract class HiveService {
  Future<void> initBoxes();
  void clearPrefs();
}

class HiveServiceImpl implements HiveService {
  HiveServiceImpl({String? hiveDBKey}) {
    _hiveDBKey = hiveDBKey ?? WDConfig.instance!.values.hiveDBKey;
  }

  late String _hiveDBKey;

  @override
  Future<void> initBoxes() async {
    await Hive.initFlutter();
    if (!Hive.isBoxOpen(_hiveDBKey)) {
      await Hive.openBox<dynamic>(_hiveDBKey);
    }
  }

  @override
  void clearPrefs() {
    Hive.box<dynamic>(_hiveDBKey).deleteAll(
      <String>[
        'token',
        'user',
      ],
    );
  }
}
