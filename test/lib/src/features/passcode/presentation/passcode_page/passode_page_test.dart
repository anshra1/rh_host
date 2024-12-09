// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:rh_host/src/core/constants/colors.dart';
// import 'package:rh_host/src/core/routes/route_name.dart';
// import 'package:rh_host/src/core/system/loading/loading_overlay.dart';
// import 'package:rh_host/src/features/batch/import.dart';
// import 'package:rh_host/src/features/passcode/import.dart';
// import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_cubit.dart';
// import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_state.dart';

// class MockPasscodeCubit extends MockCubit<PasscodeState> implements PasscodeCubit {}

// class MockGoRouter extends Mock implements GoRouter {}

// void main() {
//   late MockPasscodeCubit mockPasscodeCubit;
//   late MockGoRouter mockGoRouter;

//   setUp(() {
//     mockPasscodeCubit = MockPasscodeCubit();
//     mockGoRouter = MockGoRouter();

//     when(() => mockPasscodeCubit.state).thenReturn(const PasscodeInitial());
//     when(() => mockGoRouter.go(any())).thenAnswer((_) async {});
//   });

//   Widget createWidgetUnderTest() {
//     return MaterialApp(
//       home: BlocProvider<PasscodeCubit>.value(
//         value: mockPasscodeCubit,
//         child: InheritedGoRouter(
//           goRouter: mockGoRouter,
//           child: const PasscodePage(),
//         ),
//       ),
//     );
//   }

//   group('PasscodePage', () {
//     testWidgets('shows correct initial UI elements', (tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());

//       // Verify lock icon is displayed
//       expect(find.byIcon(Icons.lock_outline), findsOneWidget);

//       // Verify "Please enter pin code" text
//       expect(find.text('Please enter pin code'), findsOneWidget);

//       // Verify "Forget PIN?" button
//       expect(find.text('Forget PIN?'), findsOneWidget);

//       // Verify keypad numbers are displayed
//       for (var i = 0; i <= 9; i++) {
//         expect(find.text('$i'), findsOneWidget);
//       }

//       // Verify backspace button
//       expect(find.text('⌫'), findsOneWidget);
//     });

//     testWidgets('handles passcode input correctly', (tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());

//       // Initially no filled dots
//       expect(
//         find.byWidgetPredicate(
//           (widget) => widget is Container && 
//                       widget.color == AppColor.primaryColor,
//         ),
//         findsNothing,
//       );

//       // Enter 4 digits
//       await tester.tap(find.text('1'));
//       await tester.pump();
//       await tester.tap(find.text('2'));
//       await tester.pump();
//       await tester.tap(find.text('3'));
//       await tester.pump();
//       await tester.tap(find.text('4'));
//       await tester.pump();

//       // Verify 4 filled dots
//       expect(
//         find.byWidgetPredicate(
//           (widget) => widget is Container && 
//                       widget.color == AppColor.primaryColor,
//         ),
//         findsNWidgets(4),
//       );

//       // Verify verifyPasscode was called
//       verify(() => mockPasscodeCubit.verifyPasscode(1234)).called(1);
//     });

//     testWidgets('handles backspace correctly', (tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());

//       // Enter 2 digits
//       await tester.tap(find.text('1'));
//       await tester.pump();
//       await tester.tap(find.text('2'));
//       await tester.pump();

//       // Initially 2 filled dots
//       expect(
//         find.byWidgetPredicate(
//           (widget) => widget is Container && 
//                       widget.color == AppColor.primaryColor,
//         ),
//         findsNWidgets(2),
//       );

//       // Press backspace
//       await tester.tap(find.text('⌫'));
//       await tester.pump();

//       // Verify now only 1 filled dot
//       expect(
//         find.byWidgetPredicate(
//           (widget) => widget is Container && 
//                       widget.color == AppColor.primaryColor,
//         ),
//         findsNWidgets(1),
//       );
//     });

//     testWidgets('shows error state correctly', (tester) async {
//       when(() => mockPasscodeCubit.state)
//           .thenReturn(const PasscodeInvalid());
      
//       await tester.pumpWidget(createWidgetUnderTest());

//       // Verify error icon and message
//       expect(find.byIcon(Icons.error_outline), findsOneWidget);
//       expect(find.text('Invalid pin code'), findsOneWidget);
//     });

//     testWidgets('navigates on forget pin tap', (tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());

//       await tester.tap(find.text('Forget PIN?'));
//       await tester.pump();

//       verify(() => mockGoRouter.go(RouteName.resetPinPage)).called(1);
//     });

//     testWidgets('handles loading state correctly', (tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());

//       // Simulate loading state
//       when(() => mockPasscodeCubit.state)
//           .thenReturn(const PasscodeLoading());
      
//       // Enter complete passcode to trigger loading
//       await tester.tap(find.text('1'));
//       await tester.tap(find.text('2'));
//       await tester.tap(find.text('3'));
//       await tester.tap(find.text('4'));
//       await tester.pump();

//       // Verify loading indicator
//       expect(find.byType(LoadingOverlay), findsOneWidget);
//       expect(find.text('Verifying passcode...'), findsOneWidget);
//     });

//     testWidgets('navigates on successful verification', (tester) async {
//       await tester.pumpWidget(createWidgetUnderTest());

//       // Simulate verified state
//       when(() => mockPasscodeCubit.state)
//           .thenReturn(const PasscodeVerified());
      
//       await tester.pump();

//       verify(() => mockGoRouter.go(HomePage.routeName)).called(1);
//     });
//   });
// }