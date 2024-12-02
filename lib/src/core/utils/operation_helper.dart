import 'package:rh_host/src/core/constants/string.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/error/errror_system/retry_policy.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/error/exception/exception_thrower.dart';
import 'package:rh_host/src/core/system/network/network_info.dart';

/// Helper functions for remote data source operations
class RemoteDataSourceHelper {
  const RemoteDataSourceHelper._();

  /// Executes a remote operation with standardized error handling, network checks, and retry capability
  static Future<T> executeRetryOperation<T>({
    required Future<T> Function() operation,
    required String methodName,
    required NetworkCheckerSealed networkInfo,
    required RetryPolicy retryPolicy,
    bool requiresNetwork = true,
    bool shouldRetry = true,
  }) async {
    try {
      if (requiresNetwork && !await networkInfo.isConnected) {
        throw NetworkException(
          showUImessage: Strings.noInternetConnection,
          debugCode: 'no_internet',
          methodName: methodName,
          errorCode: ErrorCode.noInternet,
        );
      }

      if (shouldRetry) {
        return await retryPolicy.execute(operation);
      }

      return await operation();
    } on AppException {
      rethrow;
    } catch (e, s) {
      if (requiresNetwork && !await networkInfo.isConnected) {
        throw NetworkException(
          showUImessage: Strings.connectionLostDuringOperation,
          debugCode: 'Connection_lost',
          methodName: methodName,
          errorCode: ErrorCode.connectionLost,
        );
      }
      throw ExceptionThrower.throwUnknownExceptionWithFirebase(
        error: e,
        stackTrace: s,
        methodName: methodName,
      );
    }
  }
}

// // Usage in PasscodeRemoteDataSourceImpl
// class PasscodeRemoteDataSourceImpl implements PasscodeRemoteDataSource {
//   PasscodeRemoteDataSourceImpl({
//     required FirebaseFirestore firestoreClient,
//     required SharedPrefsStorage prefs,
//     required TimeProvider timeProvider,
//     required NetworkChecker networkInfo,
//     required RetryPolicy retryPolicy,
//   })  : _firestoreClient = firestoreClient,
//         _prefs = prefs,
//         _timeProvider = timeProvider,
//         _networkInfo = networkInfo,
//         _retryPolicy = retryPolicy;

//   final FirebaseFirestore _firestoreClient;
//   final SharedPrefsStorage _prefs;
//   final TimeProvider _timeProvider;
//   final NetworkChecker _networkInfo;
//   final RetryPolicy _retryPolicy;

//   @override
//   Future<bool> verifyPasscode(int passcode) async {
//     return RemoteDataSourceHelper.executeOperation(
//       methodName: 'VERIFY_PASSCODE',
//       networkInfo: _networkInfo,
//       retryPolicy: _retryPolicy,
//       operation: () async {
//         final docSnapshot = await _getPasscodeDocument();
//         await _validatePasscodeDocument(docSnapshot);
        
//         if (!await _isPasscodeValid(passcode, docSnapshot)) {
//           return false;
//         }

//         await _updateLastLoginTimestamp();
//         return true;
//       },
//     );
//   }
// }