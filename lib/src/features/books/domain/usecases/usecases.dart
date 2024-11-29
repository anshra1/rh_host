import 'package:rh_host/src/features/books/domain/repositories/repositories.dart';

class GetBooksUseCase {
  GetBooksUseCase({required this.repository});
  final BooksRepository repository;

  // Future<User> execute(String userId) async {
  //   return userRepository.getUser(userId);
  // }
}
