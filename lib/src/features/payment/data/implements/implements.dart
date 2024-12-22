import 'package:rh_host/src/features/payment/data/sources/sources.dart';
import 'package:rh_host/src/features/payment/domain/repositories/repositories.dart';

class PaymentRepositoryImp implements PaymentRepository {
  PaymentRepositoryImp({required this.remoteDataSource});

  final PaymentRemoteDataSource remoteDataSource;

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
