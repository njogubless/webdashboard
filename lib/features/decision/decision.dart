import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webdashboard/features/decision/welcome.dart';
import 'package:webdashboard/features/sections/_sections.dart';
import 'package:webdashboard/shared_models/_index.dart';
import 'package:webdashboard/utils/_index.dart';

class DecisionPage extends StatefulWidget {
  const DecisionPage({
    super.key,
  });

  @override
  State<DecisionPage> createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ValueListenableBuilder(
      valueListenable:
          Hive.box<dynamic>(WDConfig.instance!.values.hiveDBKey).listenable(),
      builder: (context, Box<dynamic> box, _) {
        final user = box.get('user') as LocalAuth?;

        if (user != null) {
          _redirectToPage(
            context,
            const SectionsPage(),
            routeName: WDRouter.sectionsRoute,
          );
        }

        if (user == null) {
          _redirectToPage(
            context,
            const WelcomePage(),
            routeName: WDRouter.welcomeRoute,
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Align(
            child: Image.asset(
              'assets/images/logo.png',
              height: 75,
            ),
          ),
        );
      },
    );
  }

  void _redirectToPage(BuildContext context, Widget page, {String? routeName}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newRoute = CupertinoPageRoute<dynamic>(
        builder: (BuildContext contenxt) => page,
        settings: RouteSettings(name: routeName),
      );

      Navigator.of(context).pushAndRemoveUntil<Object?>(
        newRoute,
        ModalRoute.withName(WDRouter.decisionPage),
      );
    });
  }
}
