part of 'import.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GlobalKey<NavigatorState> mainMenuNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'main_menu');

  static final GoRouter router = GoRouter(
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: const PageUnderConstruction(),
      );
    },
    navigatorKey: _rootNavigatorKey,
    initialLocation: PasscodePage.routeName,
    routes: [
      GoRoute(
        path: PasscodePage.routeName,
        name: PasscodePage.routeName,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: const PasscodePage(),
            state: state,
          );
        },
      ),
      ShellRoute(
        navigatorKey: mainMenuNavigatorKey,
        builder: (context, state, child) {
          return AppBottomNavigation(child);
        },
        routes: AppRoutes.mainMenuRoutes,
      ),
    ],
  );

  static Page<void> _buildTransition({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: kThemeAnimationDuration,
      reverseTransitionDuration: kThemeAnimationDuration,
    );
  }
}
