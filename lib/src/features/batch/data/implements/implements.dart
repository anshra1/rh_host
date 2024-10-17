
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class BatchRepositoryImp implements BatchRepository{

        final BatchRemoteDataSource remoteDataSource;
        BatchRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    