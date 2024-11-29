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
    initialLocation: RouteName.passcodePage,
    routes: [
      GoRoute(
        path: RouteName.passcodePage,
        name: RouteName.passcodePage,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: BlocProvider(
              create: (context) => sl<PasscodeCubit>(),
              child: const PasscodePage(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        path: RouteName.resetPinPage,
        name: RouteName.resetPinPage,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: const ResetPinPage(),
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
