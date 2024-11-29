part of 'import.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await _initStorage();
  await _initNetworkChecker();
  await _errorHandler();
  await _initPasscode();
}

Future<void> _initStorage() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<AppStorage>(
    () => SharedPrefsStorage(prefs: prefs),
  );
}

Future<void> _initNetworkChecker() async {
  final checker = InternetConnection.createInstance();
  sl.registerFactory<NetworkChecker>(() => NetworkCheckerImpl(checker));
}

Future<void> _errorHandler() async {
  sl.registerLazySingleton<ErrorHandler>(
    () => ErrorHandler(
      analytics: FirebaseAnalytics.instance,
      crashlytics: FirebaseCrashlytics.instance,
    ),
  );
}

Future<void> _initPasscode() async {
  sl
    ..registerFactory(
      () => PasscodeCubit(
        setNewPasscode: sl(),
        verifyPasscode: sl(),
        enableDisablePasscode: sl(),
        shouldShowPasscodeUseCase: sl(),
      ),
    )
    ..registerLazySingleton(() => SetNewPasscode(passcodeRepo: sl()))
    ..registerLazySingleton(() => VerifyPasscode(passcodeRepo: sl()))
    ..registerLazySingleton(() => EnableDisablePasscode(passcodeRepo: sl()))
    ..registerLazySingleton(() => ShouldShowPasscodeUseCase(passcodeRepo: sl()))
    //
    ..registerLazySingleton<PasscodeRepo>(
      () => PasscodeRepositoryImpl(
        remoteDataSource: sl(),
        errorHandler: sl(),
      ),
    )
    ..registerLazySingleton<PasscodeRemoteDataSource>(
      () => PasscodeRemoteDataSourceImpl(
        prefs: sl(),
        firestoreClient: FirebaseFirestore.instance,
        timeProvider: const TimeProvider(config: TimeConfig()),
        networkChecker: sl(),
        retryPolicy: sl(),
      ),
    );
}
