// ignore_for_file: inference_failure_on_instance_creation, lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rh_host/src/core/error/failure.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/enable_disable_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/set_new_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/should_show_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/verify_passcode.dart';

class MockPasscodeRepo extends Mock implements PasscodeRepo {}

void main() {
  late MockPasscodeRepo mockPasscodeRepo;
  late EnableDisablePasscode enableDisablePasscode;
  late SetNewPasscode setNewPasscode;
  late ShouldShowPasscodeUseCase shouldShowPasscode;
  late VerifyPasscode verifyPasscode;

  const tServerFailure = ServerFailure(message: '', statusCode: 301);

  setUp(() {
    mockPasscodeRepo = MockPasscodeRepo();
    enableDisablePasscode = EnableDisablePasscode(passcodeRepo: mockPasscodeRepo);
    setNewPasscode = SetNewPasscode(passcodeRepo: mockPasscodeRepo);
    shouldShowPasscode = ShouldShowPasscodeUseCase(passcodeRepo: mockPasscodeRepo);
    verifyPasscode = VerifyPasscode(passcodeRepo: mockPasscodeRepo);
  });

  group('EnableDisablePasscode', () {
    test('should call enableDisablePasscode from the repository', () async {
      when(() => mockPasscodeRepo.enableDisablePasscode())
          .thenAnswer((_) async => const Right(null));

      final result = await enableDisablePasscode();

      expect(result, const Right(null));
      verify(() => mockPasscodeRepo.enableDisablePasscode()).called(1);
    });

    test('should return Left(ServerFailure) when enableDisablePasscode fails', () async {
      when(() => mockPasscodeRepo.enableDisablePasscode())
          .thenAnswer((_) async => const Left(tServerFailure));

      final result = await enableDisablePasscode();

      expect(result, const Left(tServerFailure));
      verify(() => mockPasscodeRepo.enableDisablePasscode()).called(1);
    });
  });

  group('SetNewPasscode', () {
    const params = SetNewPasscodeParams(
      newPasscode: 123456,
      confirmPasscode: 123456,
      masterPasscode: 987654,
    );

    test('should call setNewPasscode from the repository with correct parameters',
        () async {
      when(
        () => mockPasscodeRepo.setNewPasscode(
          newPasscode: any(named: 'newPasscode'),
          confirmPasscode: any(named: 'confirmPasscode'),
          masterPasscode: any(named: 'masterPasscode'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await setNewPasscode(params);

      expect(result, const Right(null));
      verify(
        () => mockPasscodeRepo.setNewPasscode(
          newPasscode: params.newPasscode,
          confirmPasscode: params.confirmPasscode,
          masterPasscode: params.masterPasscode,
        ),
      ).called(1);
    });

    test('should return Left(ServerFailure) when setNewPasscode fails', () async {
      when(
        () => mockPasscodeRepo.setNewPasscode(
          newPasscode: any(named: 'newPasscode'),
          confirmPasscode: any(named: 'confirmPasscode'),
          masterPasscode: any(named: 'masterPasscode'),
        ),
      ).thenAnswer((_) async => const Left(tServerFailure));

      final result = await setNewPasscode(params);

      expect(result, const Left(tServerFailure));
      verify(
        () => mockPasscodeRepo.setNewPasscode(
          newPasscode: params.newPasscode,
          confirmPasscode: params.confirmPasscode,
          masterPasscode: params.masterPasscode,
        ),
      ).called(1);
    });
  });

  group('ShouldShowPasscode', () {
    test('should call shouldShowPasscode from the repository', () async {
      when(() => mockPasscodeRepo.shouldShowPasscode())
          .thenAnswer((_) async => const Right(true));

      final result = await shouldShowPasscode();

      expect(result, const Right(true));
      verify(() => mockPasscodeRepo.shouldShowPasscode()).called(1);
    });

    test('should return Left(ServerFailure) when shouldShowPasscode fails', () async {
      when(() => mockPasscodeRepo.shouldShowPasscode())
          .thenAnswer((_) async => const Left(tServerFailure));

      final result = await shouldShowPasscode();

      expect(result, const Left(tServerFailure));
      verify(() => mockPasscodeRepo.shouldShowPasscode()).called(1);
    });
  });

  group('VerifyPasscode', () {
    const testPasscode = 123456;

    test('should call verifyPasscode from the repository with correct parameter',
        () async {
      when(() => mockPasscodeRepo.verifyPasscode(any()))
          .thenAnswer((_) async => const Right(true));

      final result = await verifyPasscode(testPasscode);

      expect(result, const Right(null));
      verify(() => mockPasscodeRepo.verifyPasscode(testPasscode)).called(1);
    });

    test('should return Left(ServerFailure) when verifyPasscode fails', () async {
      when(() => mockPasscodeRepo.verifyPasscode(any()))
          .thenAnswer((_) async => const Left(tServerFailure));

      final result = await verifyPasscode(testPasscode);

      expect(result, const Left(tServerFailure));
      verify(() => mockPasscodeRepo.verifyPasscode(testPasscode)).called(1);
    });
  });
}
