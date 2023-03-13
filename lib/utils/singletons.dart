part of webdashboard_utils;

class Singletons {
  static List<ChangeNotifierProvider> registerCubits() =>
      <ChangeNotifierProvider>[
        ChangeNotifierProvider<PageNotifier>(
          create: (context) => PageNotifier(),
        ),
      ];
}
