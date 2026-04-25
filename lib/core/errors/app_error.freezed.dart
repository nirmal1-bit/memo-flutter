// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppError {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppError()';
}


}




/// Adds pattern-matching-related methods to [AppError].
extension AppErrorPatterns on AppError {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ServerError value)?  serverError,TResult Function( _ValidationError value)?  validationError,TResult Function( _NoInternet value)?  noInternet,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that);case _ValidationError() when validationError != null:
return validationError(_that);case _NoInternet() when noInternet != null:
return noInternet(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ServerError value)  serverError,required TResult Function( _ValidationError value)  validationError,required TResult Function( _NoInternet value)  noInternet,}){
final _that = this;
switch (_that) {
case _ServerError():
return serverError(_that);case _ValidationError():
return validationError(_that);case _NoInternet():
return noInternet(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ServerError value)?  serverError,TResult? Function( _ValidationError value)?  validationError,TResult? Function( _NoInternet value)?  noInternet,}){
final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that);case _ValidationError() when validationError != null:
return validationError(_that);case _NoInternet() when noInternet != null:
return noInternet(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String error)?  serverError,TResult Function( ValidationError validationError)?  validationError,TResult Function( NoInternetError error)?  noInternet,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that.error);case _ValidationError() when validationError != null:
return validationError(_that.validationError);case _NoInternet() when noInternet != null:
return noInternet(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String error)  serverError,required TResult Function( ValidationError validationError)  validationError,required TResult Function( NoInternetError error)  noInternet,}) {final _that = this;
switch (_that) {
case _ServerError():
return serverError(_that.error);case _ValidationError():
return validationError(_that.validationError);case _NoInternet():
return noInternet(_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String error)?  serverError,TResult? Function( ValidationError validationError)?  validationError,TResult? Function( NoInternetError error)?  noInternet,}) {final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that.error);case _ValidationError() when validationError != null:
return validationError(_that.validationError);case _NoInternet() when noInternet != null:
return noInternet(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ServerError implements AppError {
  const _ServerError({required this.error});
  

 final  String error;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AppError.serverError(error: $error)';
}


}




/// @nodoc


class _ValidationError implements AppError {
  const _ValidationError({required this.validationError});
  

 final  ValidationError validationError;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidationError&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,validationError);

@override
String toString() {
  return 'AppError.validationError(validationError: $validationError)';
}


}




/// @nodoc


class _NoInternet implements AppError {
  const _NoInternet({required this.error});
  

 final  NoInternetError error;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoInternet&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AppError.noInternet(error: $error)';
}


}




// dart format on
