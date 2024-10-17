import 'package:rh_host/src/core/typedef/typedef.dart';

abstract class FutureUseCaseWithParams<Type, Params> {
  const FutureUseCaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class FutureUseCaseWithoutParams<Type> {
  const FutureUseCaseWithoutParams();

  ResultFuture<Type> call();
}

abstract class StreamUseCaseWithParams<Type, Params> {
  const StreamUseCaseWithParams();

  ResultStream<Type> call(Params params);
}

abstract class StreamUseCaseWithoutParam<Type> {
  const StreamUseCaseWithoutParam();

  ResultStream<Type> call();
}