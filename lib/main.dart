import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/pages/knowledge_base/knowledge_base.dart';
import 'package:mobile_app/pages/leaders/leaders.dart';
import 'package:mobile_app/pages/profile/profile_page.dart';
import 'package:mobile_app/pages/quests/quests.dart';
import 'package:mobile_app/pages/welcome/welcome_page.dart';

import 'pages/auth/sign_in_page.dart';
import 'pages/auth/sign_up_page.dart';
import 'pages/main_page.dart';
import 'pages/road/road.dart';
import 'service/api_requests.dart';
import 'utils/app_module_container.dart';
import 'utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ModuleContainer.initialize(Injector());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authService = Injector().get<AuthService>();
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mobile app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation:
            (authService.token == '') ? Routes.welcomePage : Routes.road,
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return MainPage(
                location: state.location,
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: Routes.road,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: RoadPage()),
              ),
              GoRoute(
                path: Routes.leaders,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: LeadersPage()),
              ),
              GoRoute(
                path: Routes.quests,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: QuestPage()),
              ),
              GoRoute(
                path: Routes.knowledgeBase,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: KnowledgeBasePage()),
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: Routes.signInPage,
            pageBuilder: (context, state) => buildPageWithPopupTransition<void>(
              context: context,
              state: state,
              child: SignInPage(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: Routes.welcomePage,
            pageBuilder: (context, state) => buildPageWithPopupTransition<void>(
              context: context,
              state: state,
              child: WelcomePage(
                images: [
                  
                ],
              ),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: Routes.signUpPage,
            pageBuilder: (context, state) => buildPageWithPopupTransition<void>(
              context: context,
              state: state,
              child: SignUpPage(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: Routes.profile,
            pageBuilder: (context, state) => buildPageWithPopupTransition<void>(
              context: context,
              state: state,
              child: ProfilePage(),
            ),
          ),
        ],
      ),
    );
  }

  CustomTransitionPage buildPageWithPopupTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      opaque: false,
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
