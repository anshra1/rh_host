// Project imports:
import 'package:rh_host/src/features/payment/domain/repositories/repositories.dart';

class GetPaymentUseCase {
  GetPaymentUseCase({required this.repository});
  final PaymentRepository repository;

  // Future<User> execute(String userId) async {
  //   return userRepository.getUser(userId);
  // }
}
