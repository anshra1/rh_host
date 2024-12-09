// Project imports:
import 'package:rh_host/src/features/batch/data/sources/sources.dart';
import 'package:rh_host/src/features/batch/domain/repositories/repositories.dart';

class BatchRepositoryImp implements BatchRepository {
  BatchRepositoryImp({required this.remoteDataSource});

  final BatchRemoteDataSource remoteDataSource;

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
