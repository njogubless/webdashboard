// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webdashboard/bootstrap.dart';
import 'package:webdashboard/utils/_index.dart';
import 'package:webdashboard/webdashboard/webdashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WDConfig(
    values: WDValues(
      urlScheme: 'https',
      baseDomain: 'main.nawiriwin.com',
      hiveDBKey: 'webdashboard_main',
    ),
  );

  await ScreenUtil.ensureScreenSize();

  Bloc.observer = AppBlocObserver();
  if (kReleaseMode) {
    // Log error
  }

  await runZonedGuarded(
    () async => runApp(
      MultiBlocProvider(
        providers: Singletons.registerCubits(),
        child: const WebDashboard(),
      ),
    ),
    (error, stackTrace) {
      if (kDebugMode) {
        log(error.toString(), stackTrace: stackTrace);
      } else {
        // Log Firebase error

        // FirebaseCrashlytics.instance.recordError(
        //   error,
        //   stackTrace,
        //   fatal: true,
        // );
      }
    },
  );
}
