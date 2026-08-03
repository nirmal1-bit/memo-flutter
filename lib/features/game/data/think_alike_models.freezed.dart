// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'think_alike_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThinkAlikeQuestion {

 int get id; String get question; String? get category;
/// Create a copy of ThinkAlikeQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThinkAlikeQuestionCopyWith<ThinkAlikeQuestion> get copyWith => _$ThinkAlikeQuestionCopyWithImpl<ThinkAlikeQuestion>(this as ThinkAlikeQuestion, _$identity);

  /// Serializes this ThinkAlikeQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThinkAlikeQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,category);

@override
String toString() {
  return 'ThinkAlikeQuestion(id: $id, question: $question, category: $category)';
}


}

/// @nodoc
abstract mixin class $ThinkAlikeQuestionCopyWith<$Res>  {
  factory $ThinkAlikeQuestionCopyWith(ThinkAlikeQuestion value, $Res Function(ThinkAlikeQuestion) _then) = _$ThinkAlikeQuestionCopyWithImpl;
@useResult
$Res call({
 int id, String question, String? category
});




}
/// @nodoc
class _$ThinkAlikeQuestionCopyWithImpl<$Res>
    implements $ThinkAlikeQuestionCopyWith<$Res> {
  _$ThinkAlikeQuestionCopyWithImpl(this._self, this._then);

  final ThinkAlikeQuestion _self;
  final $Res Function(ThinkAlikeQuestion) _then;

/// Create a copy of ThinkAlikeQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? category = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ThinkAlikeQuestion].
extension ThinkAlikeQuestionPatterns on ThinkAlikeQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThinkAlikeQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThinkAlikeQuestion() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThinkAlikeQuestion value)  $default,){
final _that = this;
switch (_that) {
case _ThinkAlikeQuestion():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThinkAlikeQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _ThinkAlikeQuestion() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String question,  String? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThinkAlikeQuestion() when $default != null:
return $default(_that.id,_that.question,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String question,  String? category)  $default,) {final _that = this;
switch (_that) {
case _ThinkAlikeQuestion():
return $default(_that.id,_that.question,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String question,  String? category)?  $default,) {final _that = this;
switch (_that) {
case _ThinkAlikeQuestion() when $default != null:
return $default(_that.id,_that.question,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThinkAlikeQuestion implements ThinkAlikeQuestion {
  const _ThinkAlikeQuestion({required this.id, required this.question, this.category});
  factory _ThinkAlikeQuestion.fromJson(Map<String, dynamic> json) => _$ThinkAlikeQuestionFromJson(json);

@override final  int id;
@override final  String question;
@override final  String? category;

/// Create a copy of ThinkAlikeQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThinkAlikeQuestionCopyWith<_ThinkAlikeQuestion> get copyWith => __$ThinkAlikeQuestionCopyWithImpl<_ThinkAlikeQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThinkAlikeQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThinkAlikeQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,category);

@override
String toString() {
  return 'ThinkAlikeQuestion(id: $id, question: $question, category: $category)';
}


}

/// @nodoc
abstract mixin class _$ThinkAlikeQuestionCopyWith<$Res> implements $ThinkAlikeQuestionCopyWith<$Res> {
  factory _$ThinkAlikeQuestionCopyWith(_ThinkAlikeQuestion value, $Res Function(_ThinkAlikeQuestion) _then) = __$ThinkAlikeQuestionCopyWithImpl;
@override @useResult
$Res call({
 int id, String question, String? category
});




}
/// @nodoc
class __$ThinkAlikeQuestionCopyWithImpl<$Res>
    implements _$ThinkAlikeQuestionCopyWith<$Res> {
  __$ThinkAlikeQuestionCopyWithImpl(this._self, this._then);

  final _ThinkAlikeQuestion _self;
  final $Res Function(_ThinkAlikeQuestion) _then;

/// Create a copy of ThinkAlikeQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? category = freezed,}) {
  return _then(_ThinkAlikeQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ThinkAlikeSession {

 int get id;@JsonKey(name: 'question_id') int get questionId;@JsonKey(name: 'started_by_user_id') int get startedByUserId;@JsonKey(name: 'initiator_id') int get initiatorId;@JsonKey(name: 'partner_id') int get partnerId; ThinkAlikeQuestion? get question;@JsonKey(name: 'initiator_answer') String? get initiatorAnswer;@JsonKey(name: 'partner_answer') String? get partnerAnswer; String get status;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of ThinkAlikeSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThinkAlikeSessionCopyWith<ThinkAlikeSession> get copyWith => _$ThinkAlikeSessionCopyWithImpl<ThinkAlikeSession>(this as ThinkAlikeSession, _$identity);

  /// Serializes this ThinkAlikeSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThinkAlikeSession&&(identical(other.id, id) || other.id == id)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.startedByUserId, startedByUserId) || other.startedByUserId == startedByUserId)&&(identical(other.initiatorId, initiatorId) || other.initiatorId == initiatorId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId)&&(identical(other.question, question) || other.question == question)&&(identical(other.initiatorAnswer, initiatorAnswer) || other.initiatorAnswer == initiatorAnswer)&&(identical(other.partnerAnswer, partnerAnswer) || other.partnerAnswer == partnerAnswer)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,questionId,startedByUserId,initiatorId,partnerId,question,initiatorAnswer,partnerAnswer,status,createdAt,updatedAt);

@override
String toString() {
  return 'ThinkAlikeSession(id: $id, questionId: $questionId, startedByUserId: $startedByUserId, initiatorId: $initiatorId, partnerId: $partnerId, question: $question, initiatorAnswer: $initiatorAnswer, partnerAnswer: $partnerAnswer, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ThinkAlikeSessionCopyWith<$Res>  {
  factory $ThinkAlikeSessionCopyWith(ThinkAlikeSession value, $Res Function(ThinkAlikeSession) _then) = _$ThinkAlikeSessionCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'question_id') int questionId,@JsonKey(name: 'started_by_user_id') int startedByUserId,@JsonKey(name: 'initiator_id') int initiatorId,@JsonKey(name: 'partner_id') int partnerId, ThinkAlikeQuestion? question,@JsonKey(name: 'initiator_answer') String? initiatorAnswer,@JsonKey(name: 'partner_answer') String? partnerAnswer, String status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


$ThinkAlikeQuestionCopyWith<$Res>? get question;

}
/// @nodoc
class _$ThinkAlikeSessionCopyWithImpl<$Res>
    implements $ThinkAlikeSessionCopyWith<$Res> {
  _$ThinkAlikeSessionCopyWithImpl(this._self, this._then);

  final ThinkAlikeSession _self;
  final $Res Function(ThinkAlikeSession) _then;

/// Create a copy of ThinkAlikeSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? questionId = null,Object? startedByUserId = null,Object? initiatorId = null,Object? partnerId = null,Object? question = freezed,Object? initiatorAnswer = freezed,Object? partnerAnswer = freezed,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,startedByUserId: null == startedByUserId ? _self.startedByUserId : startedByUserId // ignore: cast_nullable_to_non_nullable
as int,initiatorId: null == initiatorId ? _self.initiatorId : initiatorId // ignore: cast_nullable_to_non_nullable
as int,partnerId: null == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as int,question: freezed == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as ThinkAlikeQuestion?,initiatorAnswer: freezed == initiatorAnswer ? _self.initiatorAnswer : initiatorAnswer // ignore: cast_nullable_to_non_nullable
as String?,partnerAnswer: freezed == partnerAnswer ? _self.partnerAnswer : partnerAnswer // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of ThinkAlikeSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThinkAlikeQuestionCopyWith<$Res>? get question {
    if (_self.question == null) {
    return null;
  }

  return $ThinkAlikeQuestionCopyWith<$Res>(_self.question!, (value) {
    return _then(_self.copyWith(question: value));
  });
}
}


/// Adds pattern-matching-related methods to [ThinkAlikeSession].
extension ThinkAlikeSessionPatterns on ThinkAlikeSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThinkAlikeSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThinkAlikeSession() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThinkAlikeSession value)  $default,){
final _that = this;
switch (_that) {
case _ThinkAlikeSession():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThinkAlikeSession value)?  $default,){
final _that = this;
switch (_that) {
case _ThinkAlikeSession() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'question_id')  int questionId, @JsonKey(name: 'started_by_user_id')  int startedByUserId, @JsonKey(name: 'initiator_id')  int initiatorId, @JsonKey(name: 'partner_id')  int partnerId,  ThinkAlikeQuestion? question, @JsonKey(name: 'initiator_answer')  String? initiatorAnswer, @JsonKey(name: 'partner_answer')  String? partnerAnswer,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThinkAlikeSession() when $default != null:
return $default(_that.id,_that.questionId,_that.startedByUserId,_that.initiatorId,_that.partnerId,_that.question,_that.initiatorAnswer,_that.partnerAnswer,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'question_id')  int questionId, @JsonKey(name: 'started_by_user_id')  int startedByUserId, @JsonKey(name: 'initiator_id')  int initiatorId, @JsonKey(name: 'partner_id')  int partnerId,  ThinkAlikeQuestion? question, @JsonKey(name: 'initiator_answer')  String? initiatorAnswer, @JsonKey(name: 'partner_answer')  String? partnerAnswer,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ThinkAlikeSession():
return $default(_that.id,_that.questionId,_that.startedByUserId,_that.initiatorId,_that.partnerId,_that.question,_that.initiatorAnswer,_that.partnerAnswer,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'question_id')  int questionId, @JsonKey(name: 'started_by_user_id')  int startedByUserId, @JsonKey(name: 'initiator_id')  int initiatorId, @JsonKey(name: 'partner_id')  int partnerId,  ThinkAlikeQuestion? question, @JsonKey(name: 'initiator_answer')  String? initiatorAnswer, @JsonKey(name: 'partner_answer')  String? partnerAnswer,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ThinkAlikeSession() when $default != null:
return $default(_that.id,_that.questionId,_that.startedByUserId,_that.initiatorId,_that.partnerId,_that.question,_that.initiatorAnswer,_that.partnerAnswer,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThinkAlikeSession implements ThinkAlikeSession {
  const _ThinkAlikeSession({required this.id, @JsonKey(name: 'question_id') required this.questionId, @JsonKey(name: 'started_by_user_id') required this.startedByUserId, @JsonKey(name: 'initiator_id') required this.initiatorId, @JsonKey(name: 'partner_id') required this.partnerId, this.question, @JsonKey(name: 'initiator_answer') this.initiatorAnswer, @JsonKey(name: 'partner_answer') this.partnerAnswer, required this.status, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _ThinkAlikeSession.fromJson(Map<String, dynamic> json) => _$ThinkAlikeSessionFromJson(json);

@override final  int id;
@override@JsonKey(name: 'question_id') final  int questionId;
@override@JsonKey(name: 'started_by_user_id') final  int startedByUserId;
@override@JsonKey(name: 'initiator_id') final  int initiatorId;
@override@JsonKey(name: 'partner_id') final  int partnerId;
@override final  ThinkAlikeQuestion? question;
@override@JsonKey(name: 'initiator_answer') final  String? initiatorAnswer;
@override@JsonKey(name: 'partner_answer') final  String? partnerAnswer;
@override final  String status;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of ThinkAlikeSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThinkAlikeSessionCopyWith<_ThinkAlikeSession> get copyWith => __$ThinkAlikeSessionCopyWithImpl<_ThinkAlikeSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThinkAlikeSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThinkAlikeSession&&(identical(other.id, id) || other.id == id)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.startedByUserId, startedByUserId) || other.startedByUserId == startedByUserId)&&(identical(other.initiatorId, initiatorId) || other.initiatorId == initiatorId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId)&&(identical(other.question, question) || other.question == question)&&(identical(other.initiatorAnswer, initiatorAnswer) || other.initiatorAnswer == initiatorAnswer)&&(identical(other.partnerAnswer, partnerAnswer) || other.partnerAnswer == partnerAnswer)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,questionId,startedByUserId,initiatorId,partnerId,question,initiatorAnswer,partnerAnswer,status,createdAt,updatedAt);

@override
String toString() {
  return 'ThinkAlikeSession(id: $id, questionId: $questionId, startedByUserId: $startedByUserId, initiatorId: $initiatorId, partnerId: $partnerId, question: $question, initiatorAnswer: $initiatorAnswer, partnerAnswer: $partnerAnswer, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ThinkAlikeSessionCopyWith<$Res> implements $ThinkAlikeSessionCopyWith<$Res> {
  factory _$ThinkAlikeSessionCopyWith(_ThinkAlikeSession value, $Res Function(_ThinkAlikeSession) _then) = __$ThinkAlikeSessionCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'question_id') int questionId,@JsonKey(name: 'started_by_user_id') int startedByUserId,@JsonKey(name: 'initiator_id') int initiatorId,@JsonKey(name: 'partner_id') int partnerId, ThinkAlikeQuestion? question,@JsonKey(name: 'initiator_answer') String? initiatorAnswer,@JsonKey(name: 'partner_answer') String? partnerAnswer, String status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


@override $ThinkAlikeQuestionCopyWith<$Res>? get question;

}
/// @nodoc
class __$ThinkAlikeSessionCopyWithImpl<$Res>
    implements _$ThinkAlikeSessionCopyWith<$Res> {
  __$ThinkAlikeSessionCopyWithImpl(this._self, this._then);

  final _ThinkAlikeSession _self;
  final $Res Function(_ThinkAlikeSession) _then;

/// Create a copy of ThinkAlikeSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? questionId = null,Object? startedByUserId = null,Object? initiatorId = null,Object? partnerId = null,Object? question = freezed,Object? initiatorAnswer = freezed,Object? partnerAnswer = freezed,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ThinkAlikeSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,startedByUserId: null == startedByUserId ? _self.startedByUserId : startedByUserId // ignore: cast_nullable_to_non_nullable
as int,initiatorId: null == initiatorId ? _self.initiatorId : initiatorId // ignore: cast_nullable_to_non_nullable
as int,partnerId: null == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as int,question: freezed == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as ThinkAlikeQuestion?,initiatorAnswer: freezed == initiatorAnswer ? _self.initiatorAnswer : initiatorAnswer // ignore: cast_nullable_to_non_nullable
as String?,partnerAnswer: freezed == partnerAnswer ? _self.partnerAnswer : partnerAnswer // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of ThinkAlikeSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThinkAlikeQuestionCopyWith<$Res>? get question {
    if (_self.question == null) {
    return null;
  }

  return $ThinkAlikeQuestionCopyWith<$Res>(_self.question!, (value) {
    return _then(_self.copyWith(question: value));
  });
}
}

// dart format on
