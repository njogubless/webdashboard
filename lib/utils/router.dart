part of webdashboard_utils;

class WDRouter {
  static const String sectionsRoute = '/';
  static const String settingsRoute = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case sectionsRoute:
        return _route(const SectionsPage(), sectionsRoute);
      case settingsRoute:
        return _route(const SettingsPage(), settingsRoute);
      default:
        return _route(
          Scaffold(
            appBar: AppBar(
              title: const Text('Web Dashboard'),
            ),
            body: const Center(
              child: Text('Unknown page'),
            ),
          ),
          'unknown',
        );
    }
  }

  static Route<dynamic> _route(Widget page, String route) {
    if (route == sectionsRoute) {
      return PageRoutes.sharedAxis<dynamic>(
        () => page,
      );
    } else {
      return PageRoutes.slideUp<dynamic>(
        () => page,
      );
    }
  }
}
