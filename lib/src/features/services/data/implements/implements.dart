
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class ServicesRepositoryImp implements ServicesRepository{

        final ServicesRemoteDataSource remoteDataSource;
        ServicesRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    