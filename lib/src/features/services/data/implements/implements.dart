import 'package:rh_host/src/features/services/data/sources/sources.dart';
import 'package:rh_host/src/features/services/domain/repositories/repositories.dart';

class ServicesRepositoryImp implements ServicesRepository {
  ServicesRepositoryImp({required this.remoteDataSource});

  final ServicesRemoteDataSource remoteDataSource;

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
