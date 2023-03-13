import 'package:flutter/material.dart';
import 'package:webdashboard/features/authentication/sign_in/widgets/_index.dart';
import 'package:webdashboard/utils/_index.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    super.key,
    required this.pageNotifier,
  });

  final ValueNotifier<AuthPage> pageNotifier;

  @override
  Widget build(BuildContext context) {
    final hidePasswordNotifier = ValueNotifier<bool>(true);
    return ColoredBox(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    pageNotifier.value = AuthPage.signIn;
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 70),
            const Text(
              'Sign up to Nawiri',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const Text(
              'Join us by creating an account',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 30),
            InputFormField(
              hintText: 'Enter your name',
              controller: TextEditingController(),
              isUnderLine: true,
            ),
            const SizedBox(height: 30),
            InputFormField(
              hintText: 'Enter your email',
              controller: TextEditingController(),
              isEmail: true,
              isUnderLine: true,
            ),
            const SizedBox(height: 30),
            ValueListenableBuilder<bool>(
              valueListenable: hidePasswordNotifier,
              builder: (context, hidePassword, _) {
                return InputFormField(
                  hintText: 'Enter your password',
                  controller: TextEditingController(),
                  showSuffix: true,
                  isUnderLine: true,
                  hidePassword: hidePassword,
                  toggleHidePassword: () =>
                      hidePasswordNotifier.value = !hidePassword,
                );
              },
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              onPressed: () {},
              isLoading: false,
              title: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
