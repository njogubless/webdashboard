import 'package:flutter/material.dart';
import 'package:webdashboard/features/authentication/sign_in/_sign_in.dart';
import 'package:webdashboard/features/authentication/sign_up/_sign_up.dart';
import 'package:webdashboard/utils/_index.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authPageNotifier = ValueNotifier<AuthPage>(AuthPage.signIn);
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: Theme.of(context).primaryColorLight),
            ),
          ),
          Flexible(
            child: ValueListenableBuilder(
              valueListenable: authPageNotifier,
              builder: (context, page, _) {
                return page == AuthPage.signIn
                    ? SignInPage(pageNotifier: authPageNotifier)
                    : SignUpPage(pageNotifier: authPageNotifier);
              },
            ),
          )
        ],
      ),
    );
  }
}
