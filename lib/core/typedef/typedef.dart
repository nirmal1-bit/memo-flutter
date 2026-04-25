import 'package:dartz/dartz.dart';
import 'package:memo/core/errors/app_error.dart';

typedef EitherResponse<T> = Future<Either<AppError, T>>;
