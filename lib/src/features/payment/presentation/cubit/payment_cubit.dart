
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:equatable/equatable.dart';
  
  part 'payment_state.dart';
  
  class PaymentCubit extends Cubit<PaymentState> {
    PaymentCubit() : super(PaymentInitial());
  }
  