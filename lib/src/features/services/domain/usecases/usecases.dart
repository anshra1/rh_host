import 'package:rh_host/src/features/services/domain/repositories/repositories.dart';

class GetServicesUseCase {
  GetServicesUseCase({required this.repository});
  final ServicesRepository repository;

  // Future<User> execute(String userId) async {
  //   return userRepository.getUser(userId);
  // }
}
