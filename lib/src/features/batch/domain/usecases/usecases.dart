import 'package:rh_host/src/features/batch/domain/repositories/repositories.dart';

class GetBatchUseCase {
  GetBatchUseCase({required this.repository});
  final BatchRepository repository;

  // Future<User> execute(String userId) async {
  //   return userRepository.getUser(userId);
  // }
}
