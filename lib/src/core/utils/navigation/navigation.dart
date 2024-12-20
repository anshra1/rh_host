// // lib/src/design/utils/navigation/route_guard.dart
// abstract class RouteGuard {
//   FutureOr<bool> canActivate(BuildContext context, GoRouterState state);
//   String? redirectPath(BuildContext context, GoRouterState state);
// }

// class AuthGuard extends RouteGuard {

//   AuthGuard(this.authBloc);
//   final AuthBloc authBloc;

//   @override
//   FutureOr<bool> canActivate(BuildContext context, GoRouterState state) {
//     return authBloc.state.isAuthenticated;
//   }

//   @override
//   String? redirectPath(BuildContext context, GoRouterState state) {
//     return authBloc.state.isAuthenticated ? null : '/login';
//   }
// }

// class RoleGuard extends RouteGuard {

//   RoleGuard(this.authBloc, this.allowedRoles);
//   final AuthBloc authBloc;
//   final List<UserRole> allowedRoles;

//   @override
//   FutureOr<bool> canActivate(BuildContext context, GoRouterState state) {
//     return allowedRoles.contains(authBloc.state.userRole);
//   }

//   @override
//   String? redirectPath(BuildContext context, GoRouterState state) {
//     return allowedRoles.contains(authBloc.state.userRole) 
//         ? null 
//         : '/unauthorized';
//   }
// }

// // lib/src/design/utils/navigation/route_observer.dart
// class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {

//   AppRouteObserver({this.enableLogging = true});
//   final bool enableLogging;

//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didPush(route, previousRoute);
//     if (enableLogging) {
//       debugPrint(
//         'New route pushed: ${route.settings.name}'
//         '${previousRoute != null ? ' (from ${previousRoute.settings.name})' : ''}',
//       );
//     }
//   }

//   @override
//   void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
//     super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//     if (enableLogging) {
//       debugPrint(
//         'Route replaced: ${newRoute?.settings.name} '
//         'replaced ${oldRoute?.settings.name}',
//       );
//     }
//   }

//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didPop(route, previousRoute);
//     if (enableLogging) {
//       debugPrint(
//         'Route popped: ${route.settings.name}'
//         '${previousRoute != null ? ' (to ${previousRoute.settings.name})' : ''}',
//       );
//     }
//   }

//   @override
//   void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didRemove(route, previousRoute);
//     if (enableLogging) {
//       debugPrint(
//         'Route removed: ${route.settings.name}'
//         '${previousRoute != null ? ' (to ${previousRoute.settings.name})' : ''}',
//       );
//     }
//   }
// }

// // lib/src/design/utils/navigation/route_transitions.dart
// class AppPageTransitions {
//   static CustomTransitionPage<T> fade<T>({
//     required Widget child,
//     required GoRouterState state,
//     Duration duration = const Duration(milliseconds: 300),
//   }) {
//     return CustomTransitionPage<T>(
//       key: state.pageKey,
//       child: child,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//       transitionDuration: duration,
//     );
//   }

//   static CustomTransitionPage<T> slide<T>({
//     required Widget child,
//     required GoRouterState state,
//     Duration duration = const Duration(milliseconds: 300),
//     SlideDirection direction = SlideDirection.right,
//   }) {
//     return CustomTransitionPage<T>(
//       key: state.pageKey,
//       child: child,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         final begin = direction.getOffset();
//         const end = Offset.zero;
//         final tween = Tween(begin: begin, end: end);
//         final offsetAnimation = animation.drive(tween);

//         return SlideTransition(
//           position: offsetAnimation,
//           child: child,
//         );
//       },
//       transitionDuration: duration,
//     );
//   }

//   static CustomTransitionPage<T> scale<T>({
//     required Widget child,
//     required GoRouterState state,
//     Duration duration = const Duration(milliseconds: 300),
//   }) {
//     return CustomTransitionPage<T>(
//       key: state.pageKey,
//       child: child,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return ScaleTransition(
//           scale: animation,
//           child: child,
//         );
//       },
//       transitionDuration: duration,
//     );
//   }
// }

// enum SlideDirection {
//   left,
//   right,
//   up,
//   down;

//   Offset getOffset() {
//     switch (this) {
//       case SlideDirection.left:
//         return const Offset(-1.0, 0.0);
//       case SlideDirection.right:
//         return const Offset(1.0, 0.0);
//       case SlideDirection.up:
//         return const Offset(0.0, -1.0);
//       case SlideDirection.down:
//         return const Offset(0.0, 1.0);
//     }
//   }
// }

// // Example usage
// class AppRouter {
//   static final _rootNavigatorKey = GlobalKey<NavigatorState>();
//   static final _shellNavigatorKey = GlobalKey<NavigatorState>();
//   static final _routeObserver = AppRouteObserver();
//   static final AuthGuard _authGuard = AuthGuard(getIt<AuthBloc>());
//   static final RoleGuard _adminGuard = RoleGuard(
//     getIt<AuthBloc>(), 
//     [UserRole.admin],
//   );

//   static final router = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     observers: [_routeObserver],
//     initialLocation: '/',
//     redirect: (context, state) {
//       if (state.fullPath == '/') {
//         return '/home';
//       }
//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: '/login',
//         name: 'login',
//         pageBuilder: (context, state) => AppPageTransitions.fade(
//           child: const LoginPage(),
//           state: state,
//         ),
//       ),
//       ShellRoute(
//         navigatorKey: _shellNavigatorKey,
//         builder: (context, state, child) => AppScaffold(child: child),
//         routes: [
//           GoRoute(
//             path: '/home',
//             name: 'home',
//             pageBuilder: (context, state) => AppPageTransitions.fade(
//               child: const HomePage(),
//               state: state,
//             ),
//             redirect: _authGuard.redirectPath,
//           ),
//           GoRoute(
//             path: '/admin',
//             name: 'admin',
//             pageBuilder: (context, state) => AppPageTransitions.fade(
//               child: const AdminPage(),
//               state: state,
//             ),
//             redirect: (context, state) {
//               final authRedirect = _authGuard.redirectPath(context, state);
//               if (authRedirect != null) return authRedirect;
//               return _adminGuard.redirectPath(context,