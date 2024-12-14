// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppDateTime {
  DateTime get dateTime => throw _privateConstructorUsedError;

  /// Create a copy of AppDateTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppDateTimeCopyWith<AppDateTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDateTimeCopyWith<$Res> {
  factory $AppDateTimeCopyWith(
          AppDateTime value, $Res Function(AppDateTime) then) =
      _$AppDateTimeCopyWithImpl<$Res, AppDateTime>;
  @useResult
  $Res call({DateTime dateTime});
}

/// @nodoc
class _$AppDateTimeCopyWithImpl<$Res, $Val extends AppDateTime>
    implements $AppDateTimeCopyWith<$Res> {
  _$AppDateTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppDateTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppDateTimeImplCopyWith<$Res>
    implements $AppDateTimeCopyWith<$Res> {
  factory _$$AppDateTimeImplCopyWith(
          _$AppDateTimeImpl value, $Res Function(_$AppDateTimeImpl) then) =
      __$$AppDateTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime dateTime});
}

/// @nodoc
class __$$AppDateTimeImplCopyWithImpl<$Res>
    extends _$AppDateTimeCopyWithImpl<$Res, _$AppDateTimeImpl>
    implements _$$AppDateTimeImplCopyWith<$Res> {
  __$$AppDateTimeImplCopyWithImpl(
      _$AppDateTimeImpl _value, $Res Function(_$AppDateTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppDateTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
  }) {
    return _then(_$AppDateTimeImpl(
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AppDateTimeImpl extends _AppDateTime {
  const _$AppDateTimeImpl({required this.dateTime}) : super._();

  @override
  final DateTime dateTime;

  @override
  String toString() {
    return 'AppDateTime(dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDateTimeImpl &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateTime);

  /// Create a copy of AppDateTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDateTimeImplCopyWith<_$AppDateTimeImpl> get copyWith =>
      __$$AppDateTimeImplCopyWithImpl<_$AppDateTimeImpl>(this, _$identity);
}

abstract class _AppDateTime extends AppDateTime {
  const factory _AppDateTime({required final DateTime dateTime}) =
      _$AppDateTimeImpl;
  const _AppDateTime._() : super._();

  @override
  DateTime get dateTime;

  /// Create a copy of AppDateTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppDateTimeImplCopyWith<_$AppDateTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
