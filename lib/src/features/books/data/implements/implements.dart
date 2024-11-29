
    import 'package:rh_host/src/features/books/data/sources/sources.dart';
    import 'package:rh_host/src/features/books/domain/repositories/repositories.dart';
    
    class BooksRepositoryImp implements BooksRepository{
        BooksRepositoryImp({required this.remoteDataSource});

        final BooksRemoteDataSource remoteDataSource;
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    