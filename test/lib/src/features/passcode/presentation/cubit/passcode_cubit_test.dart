import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rh_host/src/core/error/failure.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/enable_disable_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/set_new_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/should_show_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/verify_passcode.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_cubit.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_state.dart';

class MockSetNewPasscode extends Mock implements SetNewPasscode {}
class MockVerifyPasscode extends Mock implements VerifyPasscode {}
class MockEnableDisablePasscode extends Mock implements EnableDisablePasscode {}
class MockShouldShowPasscodeUseCase extends Mock implements ShouldShowPasscodeUseCase {}

void main() {
  late PasscodeCubit passcodeBloc;
  late MockSetNewPasscode mockSetNewPasscode;
  late MockVerifyPasscode mockVerifyPasscode;
  late MockEnableDisablePasscode mockEnableDisablePasscode;
  late MockShouldShowPasscodeUseCase mockShouldShowPasscodeUseCase;

  setUp(() {
    mockSetNewPasscode = MockSetNewPasscode();
    mockVerifyPasscode = MockVerifyPasscode();
    mockEnableDisablePasscode = MockEnableDisablePasscode();
    mockShouldShowPasscodeUseCase = MockShouldShowPasscodeUseCase();
    passcodeBloc = PasscodeCubit(
      setNewPasscode: mockSetNewPasscode,
      verifyPasscode: mockVerifyPasscode,
      enableDisablePasscode: mockEnableDisablePasscode,
      shouldShowPasscodeUseCase: mockShouldShowPasscodeUseCase,
    );
  });

  tearDown(() {
    passcodeBloc.close();
  });

  group('setNewPasscode', () {
    const tParams = SetNewPasscodeParams(newPasscode: 1234, confirmPasscode: 1234, masterPasscode: 5678);

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeSet] when successful',
      build: () {
        when(() => mockSetNewPasscode(tParams)).thenAnswer((_) async => const Right(null));
        return passcodeBloc;
      },
      act: (bloc) => bloc.setNewPasscode(tParams),
      expect: () => const [PasscodeLoading(), PasscodeSet()],
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeError] when unsuccessful',
      build: () {
        when(() => mockSetNewPasscode(tParams)).thenAnswer((_) async => const Left(ServerFailure(message: 'Error', statusCode: 500)));
        return passcodeBloc;
      },
      act: (bloc) => bloc.setNewPasscode(tParams),
      expect: () => [const PasscodeLoading(), const PasscodeError('500 Error Error')],
    );
  });

  group('verifyPasscode', () {
    const tPasscode = 1234;

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeVerified] when passcode is valid',
      build: () {
        when(() => mockVerifyPasscode(tPasscode)).thenAnswer((_) async => const Right(true));
        return passcodeBloc;
      },
      act: (bloc) => bloc.verifyPasscode(tPasscode),
      expect: () => const [PasscodeLoading(), PasscodeVerified()],
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeError] when passcode is invalid',
      build: () {
        when(() => mockVerifyPasscode(tPasscode)).thenAnswer((_) async => const Right(false));
        return passcodeBloc;
      },
      act: (bloc) => bloc.verifyPasscode(tPasscode),
      expect: () => const [PasscodeLoading(), PasscodeError('Invalid passcode')],
    );
  });

  group('togglePasscodeScreen', () {
    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeSettingChanged] when successful',
      build: () {
        when(() => mockEnableDisablePasscode()).thenAnswer((_) async => const Right(null));
        return passcodeBloc;
      },
      act: (bloc) => bloc.togglePasscodeScreen(),
      expect: () => const [PasscodeLoading(), PasscodeSettingChanged()],
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeError] when unsuccessful',
      build: () {
        when(() => mockEnableDisablePasscode()).thenAnswer((_) async => const Left(ServerFailure(message: 'Error', statusCode: 500)));
        return passcodeBloc;
      },
      act: (bloc) => bloc.togglePasscodeScreen(),
      expect: () => [const PasscodeLoading(), const PasscodeError('500 Error Error')],
    );
  });

  group('checkShouldShowPasscode', () {
    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, ShouldShowPasscode(true)] when passcode should be shown',
      build: () {
        when(() => mockShouldShowPasscodeUseCase()).thenAnswer((_) async => const Right(true));
        return passcodeBloc;
      },
      act: (bloc) => bloc.checkShouldShowPasscode(),
      expect: () => const [PasscodeLoading(), ShouldShowPasscode(true)],
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, ShouldShowPasscode(false)] when passcode should not be shown',
      build: () {
        when(() => mockShouldShowPasscodeUseCase()).thenAnswer((_) async => const Right(false));
        return passcodeBloc;
      },
      act: (bloc) => bloc.checkShouldShowPasscode(),
      expect: () => const [PasscodeLoading(), ShouldShowPasscode(false)],
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeError] when unsuccessful',
      build: () {
        when(() => mockShouldShowPasscodeUseCase()).thenAnswer((_) async => const Left(ServerFailure(message: 'Error', statusCode: 500)));
        return passcodeBloc;
      },
      act: (bloc) => bloc.checkShouldShowPasscode(),
      expect: () => [const PasscodeLoading(), const PasscodeError('500 Error Error')],
    );
  });
}