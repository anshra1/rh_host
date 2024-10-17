part of 'import.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  
}


Future<void> initAuth() async {

}

// Future<void> initOnBoarding() async {
//   final prefs = await SharedPreferences.getInstance();
//   sl
//     ..registerFactory(
//       () => OnBoardingCubit(
//         checkIfUserIsFirstTimer: sl(),
//         cacheFirstTimer: sl(),
//       ),
//     )
//     ..registerLazySingleton(() => CheckIfUserIsFirstTimer(repo: sl()))
//     ..registerLazySingleton(() => CacheFirstTimer(repo: sl()))
//     //
//     ..registerLazySingleton<OnBoardingRepo>(() => OnboardingRepoImpl(sl()))
//     //
//     ..registerLazySingleton<OnboardingLocaDataSrc>(
//       () => OnBoardingLocalDataSrcImpl(sl()),
//     )
//     //
//     ..registerLazySingleton(() => prefs);
// }