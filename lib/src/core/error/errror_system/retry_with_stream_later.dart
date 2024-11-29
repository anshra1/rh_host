// // Domain Layer (core/error/retry)
// import 'package:dartz/dartz.dart';
// import 'package:rh_host/src/core/errror/failure.dart';

// sealed class RetryEvent {
//   const RetryEvent();
// }

// class RetryStarted extends RetryEvent {
//   final String operation;
//   const RetryStarted(this.operation);
// }

// class RetryInProgress extends RetryEvent {
//   final String operation;
//   final int attempt;
//   final int maxAttempts;
//   final Duration nextDelay;
//   const RetryInProgress({
//     required this.operation,
//     required this.attempt,
//     required this.maxAttempts,
//     required this.nextDelay,
//   });
// }

// class RetryFailed extends RetryEvent {
//   final String operation;
//   final dynamic error;
//   const RetryFailed(this.operation, this.error);
// }

// // Infrastructure Layer (core/error/retry_policy.dart)
// class RetryPolicy {
//   const RetryPolicy({
//     this.maxAttempts = 3,
//     this.initialDelay = const Duration(milliseconds: 200),
//     this.backoffFactor = 2.0,
//     this.retryableCodes = const {
//       ErrorCode.networkError,
//       ErrorCode.timeOut,
//       ErrorCode.serverError,
//     },
//     this.maxDelay = const Duration(seconds: 10),
//     this.shouldRetry = true,
//   });

//   final int maxAttempts;
//   final Duration initialDelay;
//   final double backoffFactor;
//   final Set<ErrorCode> retryableCodes;
//   final Duration maxDelay;
//   final bool shouldRetry;

//   Stream<RetryEvent> execute<T>({
//     required Future<T> Function() operation,
//     required String operationName,
//   }) async* {
//     var attempts = 0;
//     var currentDelay = initialDelay;

//     while (true) {
//       try {
//         attempts++;
//         yield RetryStarted(operationName);

//         final result = await operation();
//         return result;
//       } catch (error) {
//         if (!_shouldRetryError(error) || attempts >= maxAttempts) {
//           yield RetryFailed(operationName, error);
//           rethrow;
//         }

//         yield RetryInProgress(
//           operation: operationName,
//           attempt: attempts,
//           maxAttempts: maxAttempts,
//           nextDelay: currentDelay,
//         );

//         await Future<void>.delayed(currentDelay);
//         currentDelay = _nextDelay(currentDelay);
//       }
//     }
//   }

//   // ... other methods
// }

// // Data Layer (repositories)
// @override
// Stream<Either<Failure, void>> setNewPasscode({
//   required int newPasscode,
//   required int confirmPasscode,
//   required int masterPasscode,
// }) async* {
//   try {
//     await for (final event in _retryPolicy.execute(
//       operation: () => _remoteDataSource.setNewPasscode(
//         newPasscode: newPasscode,
//         confirmPasscode: confirmPasscode,
//         masterPasscode: masterPasscode,
//       ),
//       operationName: 'Setting new passcode',
//     )) {
//       switch (event) {
//         case RetryStarted():
//           yield const Right(null);
//         case RetryInProgress():
//           yield const Right(null);
//         case RetryFailed(error: final error):
//           yield Left(ErrorMapper.mapErrorToFailure(error));
//       }
//     }

//     yield const Right(null);
//   } catch (e) {
//     yield Left(ErrorMapper.mapErrorToFailure(e));
//   }
// }

// // Presentation Layer
// // Your existing LoadingScreen can be used here to show the UI feedback
// class PasscodeViewModel extends ChangeNotifier {
//   final PasscodeRepository _repository;

//   PasscodeViewModel(this._repository);

//   Future<void> setPasscode({
//     required int newPasscode,
//     required int confirmPasscode,
//     required int masterPasscode,
//   }) async {
//     await for (final result in _repository.setNewPasscode(
//       newPasscode: newPasscode,
//       confirmPasscode: confirmPasscode,
//       masterPasscode: masterPasscode,
//     )) {
//       // Handle the result in presentation layer
//       result.fold(
//         (failure) {
//           // Handle failure
//         },
//         (_) {
//           // Handle success or retry states
//         },
//       );
//     }
//   }
// }
