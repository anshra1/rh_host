
    import 'package:rh_host/src/features/home/data/sources/sources.dart';
    import 'package:rh_host/src/features/home/domain/repositories/repositories.dart';
    
    class HomeRepositoryImp implements HomeRepository{
        HomeRepositoryImp({required this.remoteDataSource});

        final HomeRemoteDataSource remoteDataSource;
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    