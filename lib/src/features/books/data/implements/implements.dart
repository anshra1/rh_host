
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class BooksRepositoryImp implements BooksRepository{

        final BooksRemoteDataSource remoteDataSource;
        BooksRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    