// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rh_host/src/core/enum/error_catogory.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/passcode_usecase.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_cubit.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_state.dart';

const tFailure = ServerFailure(
  message: 'Error',
  code: ErrorCode.serverError,
  category: ErrorCategory.server,
  isRecoverable: null,
  severity: ErrorSeverity.low,
);

class MockSetNewPasscode extends Mock implements SetNewPasscode {}

class MockVerifyPasscode extends Mock implements VerifyPasscode {}

class MockEnableDisablePasscode extends Mock implements EnableDisablePasscode {}

class MockShouldShowPasscode extends Mock implements ShouldShowPasscode {}

void main() {
  late PasscodeCubit cubit;
  late MockSetNewPasscode mockSetNewPasscode;
  late MockVerifyPasscode mockVerifyPasscode;
  late MockEnableDisablePasscode mockEnableDisablePasscode;
  late MockShouldShowPasscode mockShouldShowPasscode;

  const tNewPasscode = 123456;
  const tConfirmPasscode = 123456;
  const tMasterPasscode = 000000;

  const tParams = SetNewPasscodeParams(
    newPasscode: tNewPasscode,
    confirmPasscode: tConfirmPasscode,
    masterPasscode: tMasterPasscode,
  );

  setUp(() {
    mockSetNewPasscode = MockSetNewPasscode();
    mockVerifyPasscode = MockVerifyPasscode();
    mockEnableDisablePasscode = MockEnableDisablePasscode();
    mockShouldShowPasscode = MockShouldShowPasscode();

    cubit = PasscodeCubit(
      setNewPasscode: mockSetNewPasscode,
      verifyPasscode: mockVerifyPasscode,
      enableDisablePasscode: mockEnableDisablePasscode,
      shouldShowPasscode: mockShouldShowPasscode,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be PasscodeInitial', () {
    expect(cubit.state, const PasscodeInitialState());
  });

  group('setPasscode', () {
    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeSet] when successful',
      build: () {
        when(() => mockSetNewPasscode(tParams))
            .thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.setNewPasscode(
        newPasscode: tNewPasscode,
        confirmPasscode: tConfirmPasscode,
        masterPasscode: tMasterPasscode,
      ),
      expect: () => const [
        PasscodeLoading(),
        NewPasscodeSetState(isSet: true),
      ],
      verify: (_) {
        verify(() => mockSetNewPasscode(tParams)).called(1);
      },
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeError] when fails',
      build: () {
        when(() => mockSetNewPasscode(tParams))
            .thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.setNewPasscode(
        newPasscode: tNewPasscode,
        confirmPasscode: tConfirmPasscode,
        masterPasscode: tMasterPasscode,
      ),
      expect: () => [
        const PasscodeLoading(),
        const PasscodeErrorState(tFailure),
      ],
      verify: (_) {
        verify(() => mockSetNewPasscode(tParams)).called(1);
      },
    );
  });

  group('verifyPasscode', () {
    const tPasscode = 123456;
    const tVerifyParams = VerifyPasscodeParams(tPasscode);

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeVerified] when passcode is valid',
      build: () {
        when(() => mockVerifyPasscode(tVerifyParams))
            .thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.verifyPasscode(tPasscode),
      expect: () => const [
        PasscodeLoading(),
        PasscodeVerifiedState(isValid: true),
      ],
      verify: (_) {
        verify(() => mockVerifyPasscode(tVerifyParams)).called(1);
      },
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeInvalid] when passcode is invalid',
      build: () {
        when(() => mockVerifyPasscode(tVerifyParams))
            .thenAnswer((_) async => const Right(false));
        return cubit;
      },
      act: (cubit) => cubit.verifyPasscode(tPasscode),
      expect: () => const [
        PasscodeLoading(),
        PasscodeVerificationFailedState(),
      ],
      verify: (_) {
        verify(() => mockVerifyPasscode(tVerifyParams)).called(1);
      },
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeError] when verify fails',
      build: () {
        when(() => mockVerifyPasscode(tVerifyParams))
            .thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.verifyPasscode(tPasscode),
      expect: () => [
        const PasscodeLoading(),
        const PasscodeErrorState(tFailure),
      ],
      verify: (_) {
        verify(() => mockVerifyPasscode(tVerifyParams)).called(1);
      },
    );
  });

  group('togglePasscode', () {
    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeEnabled(true)] when enabled',
      build: () {
        when(() => mockEnableDisablePasscode())
            .thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.enableDisablePasscode(),
      expect: () => const [
        PasscodeLoading(),
        PasscodeEnabledState(isEnabled: true),
      ],
      verify: (_) {
        verify(() => mockEnableDisablePasscode()).called(1);
      },
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeEnabled(false)] when disabled',
      build: () {
        when(() => mockEnableDisablePasscode())
            .thenAnswer((_) async => const Right(false));
        return cubit;
      },
      act: (cubit) => cubit.enableDisablePasscode(),
      expect: () => const [
        PasscodeLoading(),
        PasscodeEnabledState(isEnabled: false),
      ],
      verify: (_) {
        verify(() => mockEnableDisablePasscode()).called(1);
      },
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeError] when toggle fails',
      build: () {
        when(() => mockEnableDisablePasscode())
            .thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.enableDisablePasscode(),
      expect: () => [
        const PasscodeLoading(),
        const PasscodeErrorState(tFailure),
      ],
      verify: (_) {
        verify(() => mockEnableDisablePasscode()).called(1);
      },
    );
  });

  group('checkShouldShowPasscode', () {
    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeShowRequired(true)] when should show',
      build: () {
        when(() => mockShouldShowPasscode()).thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.shouldShowPasscode(),
      expect: () => const [
        PasscodeLoading(),
        PasscodeShowRequiredState(shouldShow: true),
      ],
      verify: (_) {
        verify(() => mockShouldShowPasscode()).called(1);
      },
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeShowRequired(false)] when should not show',
      build: () {
        when(() => mockShouldShowPasscode()).thenAnswer((_) async => const Right(false));
        return cubit;
      },
      act: (cubit) => cubit.shouldShowPasscode(),
      expect: () => const [
        PasscodeLoading(),
        PasscodeShowRequiredState(shouldShow: false),
      ],
      verify: (_) {
        verify(() => mockShouldShowPasscode()).called(1);
      },
    );

    blocTest<PasscodeCubit, PasscodeState>(
      'emits [PasscodeLoading, PasscodeError] when check fails',
      build: () {
        when(() => mockShouldShowPasscode())
            .thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.shouldShowPasscode(),
      expect: () => [
        const PasscodeLoading(),
        const PasscodeErrorState(tFailure),
      ],
      verify: (_) {
        verify(() => mockShouldShowPasscode()).called(1);
      },
    );
  });
}
