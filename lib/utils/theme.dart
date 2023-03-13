part of webdashboard_utils;

class WDTheme {
  static ThemeData theme() => ThemeData(
        // fontFamily: 'SatoshiRegular',
        primaryColor: const Color(0xFFFFFFFF),
        primaryColorDark: const Color(0xFF000000),
        primaryColorLight: const Color(0xFF2A2B2E),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF2A2B2E),
          backgroundColor: const Color(0xFF000000),
          primaryColorDark: const Color(0xFFFFFFFF),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(),
        scaffoldBackgroundColor: const Color(
          0xFF000000,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(
            0xFF000000,
          ),
          titleTextStyle: TextStyle(
            color: Color(
              0xFFFFFFFF,
            ),
            // fontFamily: 'SatoshiRegular',
          ),
        ),
      );
}
