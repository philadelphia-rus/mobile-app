import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:go_router/go_router.dart';

import 'pages/auth/sign_in_page.dart';
import 'pages/main_page.dart';
import 'service/auth_service.dart';
import 'utils/app_module_container.dart';
import 'utils/app_routes.dart';

void main() async {
  await ModuleContainer.initialize(Injector());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authService = Injector().get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mobile app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        initialLocation:
            (authService.token == '') ? Routes.signInPage : Routes.mainPage,
        routes: <GoRoute>[
          GoRoute(
            path: Routes.mainPage,
            builder: (context, state) => MainPage(),
          ),
          GoRoute(
            path: Routes.signInPage,
            builder: (context, state) => SignInPage(),
          ),
        ],
      ),
    );
  }
}