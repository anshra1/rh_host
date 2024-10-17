
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:equatable/equatable.dart';
  
  part 'books_state.dart';
  
  class BooksCubit extends Cubit<BooksState> {
    BooksCubit() : super(BooksInitial());
  }
  