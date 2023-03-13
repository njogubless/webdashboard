part of webdashboard_utils;

class Singletons {
  static List<BlocProvider> registerCubits() => [
        BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(),
        ),
      ];
}
