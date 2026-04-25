// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_api_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BaseApiState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseApiState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseApiState<$T>()';
}


}

/// @nodoc
class $BaseApiStateCopyWith<T,$Res>  {
$BaseApiStateCopyWith(BaseApiState<T> _, $Res Function(BaseApiState<T>) __);
}


/// Adds pattern-matching-related methods to [BaseApiState].
extension BaseApiStatePatterns<T> on BaseApiState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Success<T> value)?  success,TResult Function( _Initial<T> value)?  initial,TResult Function( _Loading<T> value)?  loading,TResult Function( _Error<T> value)?  error,TResult Function( _NoInternet<T> value)?  noInternet,TResult Function( _ValidationError<T> value)?  validationError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that);case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _NoInternet() when noInternet != null:
return noInternet(_that);case _ValidationError() when validationError != null:
return validationError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Success<T> value)  success,required TResult Function( _Initial<T> value)  initial,required TResult Function( _Loading<T> value)  loading,required TResult Function( _Error<T> value)  error,required TResult Function( _NoInternet<T> value)  noInternet,required TResult Function( _ValidationError<T> value)  validationError,}){
final _that = this;
switch (_that) {
case _Success():
return success(_that);case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Error():
return error(_that);case _NoInternet():
return noInternet(_that);case _ValidationError():
return validationError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Success<T> value)?  success,TResult? Function( _Initial<T> value)?  initial,TResult? Function( _Loading<T> value)?  loading,TResult? Function( _Error<T> value)?  error,TResult? Function( _NoInternet<T> value)?  noInternet,TResult? Function( _ValidationError<T> value)?  validationError,}){
final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that);case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _NoInternet() when noInternet != null:
return noInternet(_that);case _ValidationError() when validationError != null:
return validationError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T data)?  success,TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function()?  noInternet,TResult Function( ValidationError message)?  validationError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that.data);case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case _NoInternet() when noInternet != null:
return noInternet();case _ValidationError() when validationError != null:
return validationError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T data)  success,required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function()  noInternet,required TResult Function( ValidationError message)  validationError,}) {final _that = this;
switch (_that) {
case _Success():
return success(_that.data);case _Initial():
return initial();case _Loading():
return loading();case _Error():
return error(_that.message);case _NoInternet():
return noInternet();case _ValidationError():
return validationError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T data)?  success,TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function()?  noInternet,TResult? Function( ValidationError message)?  validationError,}) {final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that.data);case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case _NoInternet() when noInternet != null:
return noInternet();case _ValidationError() when validationError != null:
return validationError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Success<T> implements BaseApiState<T> {
  const _Success(this.data);
  

 final  T data;

/// Create a copy of BaseApiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<T, _Success<T>> get copyWith => __$SuccessCopyWithImpl<T, _Success<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'BaseApiState<$T>.success(data: $data)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<T,$Res> implements $BaseApiStateCopyWith<T, $Res> {
  factory _$SuccessCopyWith(_Success<T> value, $Res Function(_Success<T>) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class __$SuccessCopyWithImpl<T,$Res>
    implements _$SuccessCopyWith<T, $Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success<T> _self;
  final $Res Function(_Success<T>) _then;

/// Create a copy of BaseApiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(_Success<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class _Initial<T> implements BaseApiState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseApiState<$T>.initial()';
}


}




/// @nodoc


class _Loading<T> implements BaseApiState<T> {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseApiState<$T>.loading()';
}


}




/// @nodoc


class _Error<T> implements BaseApiState<T> {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of BaseApiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<T, _Error<T>> get copyWith => __$ErrorCopyWithImpl<T, _Error<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BaseApiState<$T>.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<T,$Res> implements $BaseApiStateCopyWith<T, $Res> {
  factory _$ErrorCopyWith(_Error<T> value, $Res Function(_Error<T>) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<T,$Res>
    implements _$ErrorCopyWith<T, $Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error<T> _self;
  final $Res Function(_Error<T>) _then;

/// Create a copy of BaseApiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error<T>(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NoInternet<T> implements BaseApiState<T> {
  const _NoInternet();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoInternet<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseApiState<$T>.noInternet()';
}


}




/// @nodoc


class _ValidationError<T> implements BaseApiState<T> {
  const _ValidationError(this.message);
  

 final  ValidationError message;

/// Create a copy of BaseApiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidationErrorCopyWith<T, _ValidationError<T>> get copyWith => __$ValidationErrorCopyWithImpl<T, _ValidationError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidationError<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BaseApiState<$T>.validationError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ValidationErrorCopyWith<T,$Res> implements $BaseApiStateCopyWith<T, $Res> {
  factory _$ValidationErrorCopyWith(_ValidationError<T> value, $Res Function(_ValidationError<T>) _then) = __$ValidationErrorCopyWithImpl;
@useResult
$Res call({
 ValidationError message
});




}
/// @nodoc
class __$ValidationErrorCopyWithImpl<T,$Res>
    implements _$ValidationErrorCopyWith<T, $Res> {
  __$ValidationErrorCopyWithImpl(this._self, this._then);

  final _ValidationError<T> _self;
  final $Res Function(_ValidationError<T>) _then;

/// Create a copy of BaseApiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_ValidationError<T>(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ValidationError,
  ));
}


}

// dart format on
