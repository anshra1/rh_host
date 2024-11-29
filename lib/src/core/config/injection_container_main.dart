part of 'import.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await _initPasscode();
}

Future<void> _initPasscode() async {
  final prefs = await SharedPreferences.getInstance();
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
      () => PasscodeRepositoryImpl(sl()),
    )
    ..registerLazySingleton<PasscodeRemoteDataSource>(
      () => PasscodeRemoteDataSourceImpl(
        prefs: prefs,
        firestoreClient: FirebaseFirestore.instance,
      ),
    );
}
