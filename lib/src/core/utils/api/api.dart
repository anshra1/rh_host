// // lib/src/design/utils/api/api_client.dart
// class ApiClient {
//   ApiClient({
//     required this.baseUrl,
//     required this.authProvider,
//     this.timeout = const Duration(seconds: 30),
//     this.retryConfig = const RetryConfig(),
//     this.errorHandler,
//   }) : _dio = Dio(
//           BaseOptions(
//             baseUrl: baseUrl,
//             connectTimeout: timeout,
//             receiveTimeout: timeout,
//           ),
//         );

//   final String baseUrl;
//   final AuthProvider authProvider;
//   final Duration timeout;
//   final RetryConfig retryConfig;
//   final ErrorHandler? errorHandler;
//   final Dio _dio;

//   Future<void> initialize() async {
//     _dio.interceptors.addAll([
//       _AuthInterceptor(authProvider),
//       _RetryInterceptor(retryConfig),
//       _LoggingInterceptor(),
//     ]);
//   }

//   Future<T> get<T>(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.get<T>(
//         path,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } catch (error) {
//       return _handleError(error);
//     }
//   }

//   Future<T> post<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.post<T>(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } catch (error) {
//       return _handleError(error);
//     }
//   }

//   Future<T> put<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.put<T>(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } catch (error) {
//       return _handleError(error);
//     }
//   }

//   Future<T> delete<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.delete<T>(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } catch (error) {
//       return _handleError(error);
//     }
//   }

//   Future<T> _handleError<T>(dynamic error) async {
//     if (errorHandler != null) {
//       return errorHandler!.handleError<T>(error);
//     }
//     throw error;
//   }
// }

// class _AuthInterceptor extends Interceptor {
//   _AuthInterceptor(this._authProvider);

//   final AuthProvider _authProvider;

//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final token = await _authProvider.getToken();
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     handler.next(options);
//   }

//   @override
//   Future<void> onError(
//     DioError error,
//     ErrorInterceptorHandler handler,
//   ) async {
//     if (error.response?.statusCode == 401) {
//       try {
//         final newToken = await _authProvider.refreshToken();
//         if (newToken != null) {
//           final options = error.requestOptions;
//           options.headers['Authorization'] = 'Bearer $newToken';
//           final response = await Dio().fetch(options);
//           handler.resolve(response);
//           return;
//         }
//       } catch (e) {
//         // Token refresh failed
//         _authProvider.onUnauthorized();
//       }
//     }
//     handler.next(error);
//   }
// }

// class _RetryInterceptor extends Interceptor {
//   _RetryInterceptor(this._config);

//   final RetryConfig _config;
//   final _retryCount = <String, int>{};

//   @override
//   Future<void> onError(
//     DioError error,
//     ErrorInterceptorHandler handler,
//   ) async {
//     if (!_shouldRetry(error)) {
//       return handler.next(error);
//     }

//     final requestOptions = error.requestOptions;
//     final retryCount = _retryCount[requestOptions.uri.toString()] ?? 0;

//     if (retryCount >= _config.maxRetries) {
//       _retryCount.remove(requestOptions.uri.toString());
//       return handler.next(error);
//     }

//     _retryCount[requestOptions.uri.toString()] = retryCount + 1;

//     await Future.delayed(_config.retryDelay * (retryCount + 1));

//     try {
//       final response = await Dio().fetch(requestOptions);
//       handler.resolve(response);
//     } catch (e) {
//       handler.next(error);
//     }
//   }

//   bool _shouldRetry(DioError error) {
//     if (error.type == DioErrorType.connectTimeout ||
//         error.type == DioErrorType.sendTimeout ||
//         error.type == DioErrorType.receiveTimeout) {
//       return true;
//     }

//     final statusCode = error.response?.statusCode;
//     if (statusCode != null && _config.retryStatusCodes.contains(statusCode)) {
//       return true;
//     }

//     return false;
//   }
// }

// class _LoggingInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     debugPrint('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
//     debugPrint('Headers:');
//     options.headers.forEach((key, value) {
//       debugPrint('$key: $value');
//     });
//     if (options.queryParameters.isNotEmpty) {
//       debugPrint('QueryParameters:');
//       options.queryParameters.forEach((key, value) {
//         debugPrint('$key: $value');
//       });
//     }
//     if (options.data != null) {
//       debugPrint('Body: ${options.data}');
//     }
//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     debugPrint(
//       '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
//     );
//     debugPrint('Response: ${response.data}');
//     handler.next(response);
//   }

//   @override
//   void onError(DioError error, ErrorInterceptorHandler handler) {
//     debugPrint(
//       '❌ ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
//     );
//     debugPrint('Error: ${error.message}');
//     if (error.response?.data != null) {
//       debugPrint('Error Response: ${error.response?.data}');
//     }
//     handler.next(error);
//   }
// }

// class RetryConfig {
//   const RetryConfig({
//     this.maxRetries = 3,
//     this.retryDelay = const Duration(seconds: 1),
//     this.retryStatusCodes = const {408, 500, 502, 503, 504},
//   });

//   final int maxRetries;
//   final Duration retryDelay;
//   final Set<int> retryStatusCodes;
// }

// abstract class AuthProvider {
//   Future<String?> getToken();
//   Future<String?> refreshToken();
//   void onUnauthorized();
// }

// abstract class ErrorHandler {
//   Future<T> handleError<T>(dynamic error);
// }

// // Example usage
// class AppAuthProvider implements AuthProvider {
//   AppAuthProvider(this._authBloc);

//   final AuthBloc _authBloc;

//   @override
//   Future<String?> getToken() async {
//     return _authBloc.state.token;
//   }

//   @override
//   Future<String?> refreshToken() async {
//     try {
//       await _authBloc.refreshToken();
//       return _authBloc.state.token;
//     } catch (e) {
//       return null;
//     }
//   }

//   @override
//   void onUnauthorized() {
//     _authBloc.add(const AuthLogoutRequested());
//   }
// }

// class AppErrorHandler implements ErrorHandler {
//   @override
//   Future<T> handleError<T>(dynamic error) async {
//     if (error is DioError) {
//       switch (error.type) {
//         case DioErrorType.connectTimeout:
//         case DioErrorType.sendTimeout:
//         case DioErrorType.receiveTimeout:
//           throw const NetworkException(message: 'Connection timeout');
//         case DioErrorType.response:
//           final statusCode = error.response?.statusCode;
//           final data = error.response?.data;
//           throw ServerException(
//             message: data?['message'] ?? 'Server error',
//             statusCode: statusCode ?? 500,
//           );
//         case DioErrorType.cancel:
//           throw const CancelException(message: 'Request cancelled');
//         case DioErrorType.other:
//           throw const NetworkException(message: 'Network error');
//       }
//     }
//     throw const UnknownException(message: 'Unknown error');
//   }
// }

// // Usage example in a repository
// class UserRepository {
//   UserRepository(this._apiClient);

//   final ApiClient _apiClient;

//   Future<User> getCurrentUser() async {
//     final response = await _apiClient.get<Map<String, dynamic>>('/user/me');
//     return User.fromJson(response);
//   }

//   Future<List<User>> getUsers({
//     required int page,
//     required int limit,
//   }) async {
//     final response = await _apiClient.get<List<dynamic>>(
//       '/users',
//       queryParameters: {
//         'page': page,
//         'limit': limit,
//       }, 
//     );
//     return response.map(User.fromJson).toList();
//   }

//   Future<void> updateUser(User user) async {
//     await _apiClient.put<void>(
//       '/user/${user.id}',
//       data: user.toJson(),
//     );
//   }
// }
