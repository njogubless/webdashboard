import 'package:flutter/material.dart';
import 'package:webdashboard/pages/clients/clients.dart';
import 'package:webdashboard/pages/drivers/drivers.dart';
import 'package:webdashboard/pages/overview/overview.dart';
import 'package:webdashboard/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case driversPageRoute:
      return _getPageRoute(DriversPage());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    default:
      return _getPageRoute(OverviewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}