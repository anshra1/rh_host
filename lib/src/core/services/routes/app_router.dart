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
        path: ErrorBoundaryTestPage.routeName,
        name: ErrorBoundaryTestPage.routeName,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: const ErrorBoundaryTestPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: PasscodePage.routeName,
        name: PasscodePage.routeName,
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
        path: ResetPinPage.routeName,
        name: ResetPinPage.routeName,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: BlocProvider(
              create: (BuildContext context) => sl<PasscodeCubit>(),
              child: const ResetPinPage(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        path: StatusScreenSimple.routeName,
        name: StatusScreenSimple.routeName,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: StatusScreenSimple(config: state.extra! as StatusScreenModel),
            state: state,
          );
        },
      ),
      GoRoute(
        path: StatusScreenWithTimer.routeName,
        name: StatusScreenWithTimer.routeName,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: StatusScreenWithTimer(
              config: state.extra! as StatusScreenModel,
            ),
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
