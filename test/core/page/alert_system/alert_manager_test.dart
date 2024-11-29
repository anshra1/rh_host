// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:logger/logger.dart';
// import 'package:rh_host/src/core/enum/error_severity.dart';
// import 'package:rh_host/src/core/page/errror/failure.dart';
// import 'package:rh_host/src/core/page/failure/failure_manager.dart';

// // Mocks
// class MockBuildContext extends Mock implements BuildContext {}

// class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

// class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {}

// class MockLogger extends Mock implements Logger {}

// class MockScaffoldMessengerState extends Mock implements ScaffoldMessengerState {}

// class MockNavigatorState extends Mock implements NavigatorState {}

// void main() {
//   late FailureManager failureManager;
//   late MockBuildContext mockContext;
//   late MockFirebaseAnalytics mockAnalytics;
//   late MockFirebaseCrashlytics mockCrashlytics;
//   late MockLogger mockLogger;
//   late MockScaffoldMessengerState mockScaffoldMessengerState;
//   late MockNavigatorState mockNavigatorState;

//   setUp(() {
//     mockContext = MockBuildContext();
//     mockAnalytics = MockFirebaseAnalytics();
//     mockCrashlytics = MockFirebaseCrashlytics();
//     mockLogger = MockLogger();
//     mockScaffoldMessengerState = MockScaffoldMessengerState();
//     mockNavigatorState = MockNavigatorState();

//     // Setup BuildContext mocks
//     when(() => mockContext.findAncestorStateOfType<ScaffoldMessengerState>())
//         .thenReturn(mockScaffoldMessengerState);
//     when(() => mockContext.findAncestorStateOfType<NavigatorState>())
//         .thenReturn(mockNavigatorState);

//     failureManager = FailureManager();
//     failureManager.initialize(
//       config: FailureConfig(
//         defaultDuration: const Duration(seconds: 1),
//         shouldVibrate: false,
//       ),
//     );
//   });

//   group('FailureManager Tests', () {
//     test('should be singleton', () {
//       final manager1 = FailureManager();
//       final manager2 = FailureManager();
//       expect(identical(manager1, manager2), true);
//     });

//     test('should initialize with custom config', () {
//       final config = FailureConfig(
//         defaultDuration: const Duration(seconds: 2),
//         shouldVibrate: true,
//         maxVisibleSnackBars: 2,
//       );

//       failureManager.initialize(config: config);

//       // Add failure and verify config is used
//       final failure = Failure(
//         message: 'Test Error',
//         statusCode: 400,
//         severity: ErrorSeverity.medium,
//       );

//       failureManager.show(mockContext, failure);

//       verify(() => mockScaffoldMessengerState.showSnackBar(any())).called(1);
//     });

//     test('should clear queue when clearAll is called', () {
//       // Add multiple failures
//       final failures = List.generate(
//         3,
//         (i) => Failure(
//           message: 'Error $i',
//           statusCode: 400 + i,
//           severity: ErrorSeverity.medium,
//         ),
//       );

//       for (final failure in failures) {
//         failureManager.show(mockContext, failure);
//       }

//       failureManager.clearAll(mockContext);

//       verify(() => mockScaffoldMessengerState.clearSnackBars()).called(1);
//     });

//     group('Failure Display Tests', () {
//       test('should show dialog for high severity failures', () {
//         final failure = Failure(
//           message: 'Critical Error',
//           statusCode: 500,
//           severity: ErrorSeverity.high,
//         );

//         failureManager.show(mockContext, failure);

//         verify(() => mockNavigatorState.push(any())).called(1);
//       });

//       test('should show snackbar for medium severity failures', () {
//         final failure = Failure(
//           message: 'Warning',
//           statusCode: 400,
//           severity: ErrorSeverity.medium,
//         );

//         failureManager.show(mockContext, failure);

//         verify(() => mockScaffoldMessengerState.showSnackBar(any())).called(1);
//       });

//       test('should process queue in order', () async {
//         final failures = List.generate(
//           3,
//           (i) => Failure(
//             message: 'Error $i',
//             statusCode: 400 + i,
//             severity: ErrorSeverity.medium,
//           ),
//         );

//         for (final failure in failures) {
//           failureManager.show(mockContext, failure);
//         }

//         // Verify first failure is shown immediately
//         verify(() => mockScaffoldMessengerState.showSnackBar(any())).called(1);

//         // Wait for queue processing
//         await Future.delayed(const Duration(seconds: 2));

//         // Verify all failures were shown
//         verify(() => mockScaffoldMessengerState.showSnackBar(any())).called(3);
//       });
//     });

//     group('Error Utilities Tests', () {
//       test('should get correct color for severity levels', () {
//         final failures = {
//           ErrorSeverity.low: Colors.blue.shade700,
//           ErrorSeverity.medium: Colors.orange.shade700,
//           ErrorSeverity.high: Colors.red.shade700,
//           ErrorSeverity.fatal: Colors.red.shade900,
//         };

//         failures.forEach((severity, expectedColor) {
//           final failure = Failure(
//             message: 'Test',
//             statusCode: 400,
//             severity: severity,
//           );

//           final color = FailureUtils.getColor(failure);
//           expect(color, expectedColor);
//         });
//       });

//       test('should get correct icon for error codes', () {
//         final failures = {
//           ErrorCode.noInternet: Icons.wifi_off,
//           ErrorCode.unauthorized: Icons.security,
//           ErrorCode.serverError: Icons.error_outline,
//         };

//         failures.forEach((code, expectedIcon) {
//           final failure = Failure(
//             message: 'Test',
//             statusCode: 400,
//             code: code,
//           );

//           final icon = FailureUtils.getIcon(failure);
//           expect(icon, expectedIcon);
//         });
//       });
//     });
//   });

//   group('Failure Widget Tests', () {
//     testWidgets('FailureDialog shows correct content', (tester) async {
//       final failure = Failure(
//         message: 'Test Error',
//         statusCode: 500,
//         severity: ErrorSeverity.high,
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: FailureDialog(
//             failure: failure,
//             config: const FailureConfig(),
//           ),
//         ),
//       );

//       expect(find.text('Test Error'), findsOneWidget);
//       expect(find.byType(Icon), findsOneWidget);
//       expect(find.byType(TextButton), findsOneWidget);
//     });

//     testWidgets('FailureSnackBar shows correct content', (tester) async {
//       final failure = Failure(
//         message: 'Test Warning',
//         statusCode: 400,
//         severity: ErrorSeverity.medium,
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 return FailureSnackBar(
//                   failure: failure,
//                   config: const FailureConfig(),
//                 );
//               },
//             ),
//           ),
//         ),
//       );

//       expect(find.text('Test Warning'), findsOneWidget);
//       expect(find.byType(Icon), findsOneWidget);
//     });
//   });

//   group('Integration Tests', () {
//     testWidgets('Full failure flow test', (tester) async {
//       // Build test app
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     failureManager.show(
//                       context,
//                       const Failure(
//                         message: 'Test Error',
//                         statusCode: 500,
//                         severity: ErrorSeverity.high,
//                       ),
//                     );
//                   },
//                   child: const Text('Show Error'),
//                 );
//               },
//             ),
//           ),
//         ),
//       );

//       // Trigger error
//       await tester.tap(find.byType(ElevatedButton));
//       await tester.pumpAndSettle();

//       // Verify dialog shown
//       expect(find.byType(AlertDialog), findsOneWidget);
//       expect(find.text('Test Error'), findsOneWidget);

//       // Dismiss dialog
//       await tester.tap(find.text('Close'));
//       await tester.pumpAndSettle();

//       // Verify dialog dismissed
//       expect(find.byType(AlertDialog), findsNothing);
//     });
//   });
// }
