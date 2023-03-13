part of webdashboard_utils;

class WDRouter {
  static const String decisionPage = '/';
  static const String welcomeRoute = '/welcome';
  static const String sectionsRoute = '/sections';
  static const String settingsRoute = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case decisionPage:
        return _route(const DecisionPage(), decisionPage);
      case welcomeRoute:
        return _route(const WelcomePage(), welcomeRoute);
      case sectionsRoute:
        return _route(const SectionsPage(), sectionsRoute);
      case settingsRoute:
        return _route(const SettingsPage(), settingsRoute);
      default:
        return _route(
          Scaffold(
            appBar: AppBar(
              title: const Text('Nawiri Windows App'),
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
    if (route == welcomeRoute) {
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
