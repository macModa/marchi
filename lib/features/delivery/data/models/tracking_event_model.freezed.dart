// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrackingEventModel _$TrackingEventModelFromJson(Map<String, dynamic> json) {
  return _TrackingEventModel.fromJson(json);
}

/// @nodoc
mixin _$TrackingEventModel {
  int? get id => throw _privateConstructorUsedError;
  String get trackingNumber => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this TrackingEventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrackingEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackingEventModelCopyWith<TrackingEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingEventModelCopyWith<$Res> {
  factory $TrackingEventModelCopyWith(
    TrackingEventModel value,
    $Res Function(TrackingEventModel) then,
  ) = _$TrackingEventModelCopyWithImpl<$Res, TrackingEventModel>;
  @useResult
  $Res call({
    int? id,
    String trackingNumber,
    String status,
    String? location,
    DateTime timestamp,
    String? description,
  });
}

/// @nodoc
class _$TrackingEventModelCopyWithImpl<$Res, $Val extends TrackingEventModel>
    implements $TrackingEventModelCopyWith<$Res> {
  _$TrackingEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackingEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trackingNumber = null,
    Object? status = null,
    Object? location = freezed,
    Object? timestamp = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            trackingNumber: null == trackingNumber
                ? _value.trackingNumber
                : trackingNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrackingEventModelImplCopyWith<$Res>
    implements $TrackingEventModelCopyWith<$Res> {
  factory _$$TrackingEventModelImplCopyWith(
    _$TrackingEventModelImpl value,
    $Res Function(_$TrackingEventModelImpl) then,
  ) = __$$TrackingEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String trackingNumber,
    String status,
    String? location,
    DateTime timestamp,
    String? description,
  });
}

/// @nodoc
class __$$TrackingEventModelImplCopyWithImpl<$Res>
    extends _$TrackingEventModelCopyWithImpl<$Res, _$TrackingEventModelImpl>
    implements _$$TrackingEventModelImplCopyWith<$Res> {
  __$$TrackingEventModelImplCopyWithImpl(
    _$TrackingEventModelImpl _value,
    $Res Function(_$TrackingEventModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrackingEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trackingNumber = null,
    Object? status = null,
    Object? location = freezed,
    Object? timestamp = null,
    Object? description = freezed,
  }) {
    return _then(
      _$TrackingEventModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        trackingNumber: null == trackingNumber
            ? _value.trackingNumber
            : trackingNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingEventModelImpl extends _TrackingEventModel {
  const _$TrackingEventModelImpl({
    this.id,
    required this.trackingNumber,
    required this.status,
    this.location,
    required this.timestamp,
    this.description,
  }) : super._();

  factory _$TrackingEventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingEventModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String trackingNumber;
  @override
  final String status;
  @override
  final String? location;
  @override
  final DateTime timestamp;
  @override
  final String? description;

  @override
  String toString() {
    return 'TrackingEventModel(id: $id, trackingNumber: $trackingNumber, status: $status, location: $location, timestamp: $timestamp, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingEventModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.trackingNumber, trackingNumber) ||
                other.trackingNumber == trackingNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    trackingNumber,
    status,
    location,
    timestamp,
    description,
  );

  /// Create a copy of TrackingEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingEventModelImplCopyWith<_$TrackingEventModelImpl> get copyWith =>
      __$$TrackingEventModelImplCopyWithImpl<_$TrackingEventModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingEventModelImplToJson(this);
  }
}

abstract class _TrackingEventModel extends TrackingEventModel {
  const factory _TrackingEventModel({
    final int? id,
    required final String trackingNumber,
    required final String status,
    final String? location,
    required final DateTime timestamp,
    final String? description,
  }) = _$TrackingEventModelImpl;
  const _TrackingEventModel._() : super._();

  factory _TrackingEventModel.fromJson(Map<String, dynamic> json) =
      _$TrackingEventModelImpl.fromJson;

  @override
  int? get id;
  @override
  String get trackingNumber;
  @override
  String get status;
  @override
  String? get location;
  @override
  DateTime get timestamp;
  @override
  String? get description;

  /// Create a copy of TrackingEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackingEventModelImplCopyWith<_$TrackingEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
