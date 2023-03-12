import 'package:flutter/cupertino.dart';
import 'package:webdashboard/constants/controllers.dart';
import 'package:webdashboard/routing/router.dart';
import 'package:webdashboard/routing/routes.dart';

Navigator localNavigator() =>   Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: overviewPageRoute,
    );



