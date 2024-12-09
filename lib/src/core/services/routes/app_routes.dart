part of 'import.dart';

class AppRoutes {
  static final mainMenuRoutes = <RouteBase>[
    GoRoute(
      path: HomePage.routeName,
      name: HomePage.routeName,
      pageBuilder: (_, state) {
        return _buildTransition(
          child: const HomePage(),
          state: state,
        );
      },
    ),
    GoRoute(
      path: BatchPage.routeName,
      name: BatchPage.routeName,
      pageBuilder: (_, state) {
        return _buildTransition(
          child: const BatchPage(),
          state: state,
        );
      },
    ),
    GoRoute(
      path: PaymentPage.routeName,
      name: PaymentPage.routeName,
      pageBuilder: (_, state) {
        return _buildTransition(
          child: const PaymentPage(),
          state: state,
        );
      },
    ),
    GoRoute(
      path: BooksPage.routeName,
      name: BooksPage.routeName,
      pageBuilder: (_, state) {
        return _buildTransition(
          child: const BooksPage(),
          state: state,
        );
      },
    ),
    GoRoute(
      path: ServicesPage.routeName,
      name: ServicesPage.routeName,
      pageBuilder: (_, state) {
        return _buildTransition(
          child: const ServicesPage(),
          state: state,
        );
      },
    ),
  ];
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
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: kThemeAnimationDuration,
    );
  }
}
