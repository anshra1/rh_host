// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:rh_host/src/core/error/failures/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
