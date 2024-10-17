
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:equatable/equatable.dart';
  
  part 'batch_state.dart';
  
  class BatchCubit extends Cubit<BatchState> {
    BatchCubit() : super(BatchInitial());
  }
  