// ignore_for_file: unused_element

part of 'import.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await FirebaseConfig.init();
  // await _initCore();
  await _initFirebase();
  // await _initStorage();
  // await _initNetworkChecker();
  await _initErrorHandler();
  await _initPasscode();
}

Future<void> _initCore() async {
  sl
    ..registerLazySingleton(DefaultRetryPolicy.new)
    ..registerLazySingleton(() => const TimeConfig())
    ..registerLazySingleton(() => TimeProvider(config: sl()));
}

Future<void> _initFirebase() async {
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}

Future<void> _initStorage() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<AppStorage>(
    () => SharedPrefsStorages(prefs: prefs),
  );
}

Future<void> _initNetworkChecker() async {
  final checker = InternetConnection.createInstance();
  sl.registerLazySingleton<NetworkChecker>(
    () => NetworkCheckerImpl(checker),
  );
}

Future<void> _initErrorHandler() async {
  sl.registerLazySingleton<ErrorHandler>(
    () => ErrorHandler(
      analytics: FirebaseAnalytics.instance,
      crashlytics: FirebaseCrashlytics.instance,
    ),
  );
}

Future<void> _initPasscode() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    // Remote Data Source first
    ..registerLazySingleton<PasscodeRemoteDataSource>(
      () => PasscodeRemoteDataSourceImpl(
        firestoreClient: sl(),
        timeProvider: const TimeProvider(config: TimeConfig()),
        retryPolicy: DefaultRetryPolicy(),
        prefs: SharedPrefsStorages(prefs: prefs),
        networkCheckerImpl:
            NetworkCheckerImpl(InternetConnection.createInstance()),
      ),
    )
    // Repository depends on Remote Data Source
    ..registerLazySingleton<PasscodeRepo>(
      () => PasscodeRepositoryImpl(
        remoteDataSource: sl(),
        errorHandler: sl(),
      ),
    )
    // Use cases depend on Repository
    ..registerLazySingleton(() => SetNewPasscode(passcodeRepo: sl()))
    ..registerLazySingleton(() => VerifyPasscode(passcodeRepo: sl()))
    ..registerLazySingleton(() => EnableDisablePasscode(passcodeRepo: sl()))
    ..registerLazySingleton(() => ShouldShowPasscode(passcodeRepo: sl()))
    // Cubit depends on Use cases
    ..registerFactory(
      () => PasscodeCubit(
        setNewPasscode: sl(),
        verifyPasscode: sl(),
        enableDisablePasscode: sl(),
        shouldShowPasscode: sl(),
      ),
    );
}
