// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of webdashboard_models;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WDValidationError _$WDValidationErrorFromJson(Map<String, dynamic> json) {
  return _WDValidationError.fromJson(json);
}

/// @nodoc
mixin _$WDValidationError {
  int get code => throw _privateConstructorUsedError;
  List<WDFieldValidationError> get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WDValidationErrorCopyWith<WDValidationError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WDValidationErrorCopyWith<$Res> {
  factory $WDValidationErrorCopyWith(
          WDValidationError value, $Res Function(WDValidationError) then) =
      _$WDValidationErrorCopyWithImpl<$Res, WDValidationError>;
  @useResult
  $Res call({int code, List<WDFieldValidationError> errors});
}

/// @nodoc
class _$WDValidationErrorCopyWithImpl<$Res, $Val extends WDValidationError>
    implements $WDValidationErrorCopyWith<$Res> {
  _$WDValidationErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<WDFieldValidationError>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WDValidationErrorCopyWith<$Res>
    implements $WDValidationErrorCopyWith<$Res> {
  factory _$$_WDValidationErrorCopyWith(_$_WDValidationError value,
          $Res Function(_$_WDValidationError) then) =
      __$$_WDValidationErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, List<WDFieldValidationError> errors});
}

/// @nodoc
class __$$_WDValidationErrorCopyWithImpl<$Res>
    extends _$WDValidationErrorCopyWithImpl<$Res, _$_WDValidationError>
    implements _$$_WDValidationErrorCopyWith<$Res> {
  __$$_WDValidationErrorCopyWithImpl(
      _$_WDValidationError _value, $Res Function(_$_WDValidationError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? errors = null,
  }) {
    return _then(_$_WDValidationError(
      null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<WDFieldValidationError>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WDValidationError implements _WDValidationError {
  _$_WDValidationError(this.code, final List<WDFieldValidationError> errors)
      : _errors = errors;

  factory _$_WDValidationError.fromJson(Map<String, dynamic> json) =>
      _$$_WDValidationErrorFromJson(json);

  @override
  final int code;
  final List<WDFieldValidationError> _errors;
  @override
  List<WDFieldValidationError> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'WDValidationError(code: $code, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WDValidationError &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WDValidationErrorCopyWith<_$_WDValidationError> get copyWith =>
      __$$_WDValidationErrorCopyWithImpl<_$_WDValidationError>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WDValidationErrorToJson(
      this,
    );
  }
}

abstract class _WDValidationError implements WDValidationError {
  factory _WDValidationError(
          final int code, final List<WDFieldValidationError> errors) =
      _$_WDValidationError;

  factory _WDValidationError.fromJson(Map<String, dynamic> json) =
      _$_WDValidationError.fromJson;

  @override
  int get code;
  @override
  List<WDFieldValidationError> get errors;
  @override
  @JsonKey(ignore: true)
  _$$_WDValidationErrorCopyWith<_$_WDValidationError> get copyWith =>
      throw _privateConstructorUsedError;
}

WDFieldValidationError _$WDFieldValidationErrorFromJson(
    Map<String, dynamic> json) {
  return _WDFieldValidationError.fromJson(json);
}

/// @nodoc
mixin _$WDFieldValidationError {
  String get key => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WDFieldValidationErrorCopyWith<WDFieldValidationError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WDFieldValidationErrorCopyWith<$Res> {
  factory $WDFieldValidationErrorCopyWith(WDFieldValidationError value,
          $Res Function(WDFieldValidationError) then) =
      _$WDFieldValidationErrorCopyWithImpl<$Res, WDFieldValidationError>;
  @useResult
  $Res call({String key, List<String> errors});
}

/// @nodoc
class _$WDFieldValidationErrorCopyWithImpl<$Res,
        $Val extends WDFieldValidationError>
    implements $WDFieldValidationErrorCopyWith<$Res> {
  _$WDFieldValidationErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WDFieldValidationErrorCopyWith<$Res>
    implements $WDFieldValidationErrorCopyWith<$Res> {
  factory _$$_WDFieldValidationErrorCopyWith(_$_WDFieldValidationError value,
          $Res Function(_$_WDFieldValidationError) then) =
      __$$_WDFieldValidationErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, List<String> errors});
}

/// @nodoc
class __$$_WDFieldValidationErrorCopyWithImpl<$Res>
    extends _$WDFieldValidationErrorCopyWithImpl<$Res,
        _$_WDFieldValidationError>
    implements _$$_WDFieldValidationErrorCopyWith<$Res> {
  __$$_WDFieldValidationErrorCopyWithImpl(_$_WDFieldValidationError _value,
      $Res Function(_$_WDFieldValidationError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? errors = null,
  }) {
    return _then(_$_WDFieldValidationError(
      null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WDFieldValidationError implements _WDFieldValidationError {
  _$_WDFieldValidationError(this.key, final List<String> errors)
      : _errors = errors;

  factory _$_WDFieldValidationError.fromJson(Map<String, dynamic> json) =>
      _$$_WDFieldValidationErrorFromJson(json);

  @override
  final String key;
  final List<String> _errors;
  @override
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'WDFieldValidationError(key: $key, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WDFieldValidationError &&
            (identical(other.key, key) || other.key == key) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, key, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WDFieldValidationErrorCopyWith<_$_WDFieldValidationError> get copyWith =>
      __$$_WDFieldValidationErrorCopyWithImpl<_$_WDFieldValidationError>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WDFieldValidationErrorToJson(
      this,
    );
  }
}

abstract class _WDFieldValidationError implements WDFieldValidationError {
  factory _WDFieldValidationError(final String key, final List<String> errors) =
      _$_WDFieldValidationError;

  factory _WDFieldValidationError.fromJson(Map<String, dynamic> json) =
      _$_WDFieldValidationError.fromJson;

  @override
  String get key;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$_WDFieldValidationErrorCopyWith<_$_WDFieldValidationError> get copyWith =>
      throw _privateConstructorUsedError;
}

LocalAuth _$LocalAuthFromJson(Map<String, dynamic> json) {
  return _LocalAuth.fromJson(json);
}

/// @nodoc
mixin _$LocalAuth {
  String get token => throw _privateConstructorUsedError;
  LocalUser get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalAuthCopyWith<LocalAuth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalAuthCopyWith<$Res> {
  factory $LocalAuthCopyWith(LocalAuth value, $Res Function(LocalAuth) then) =
      _$LocalAuthCopyWithImpl<$Res, LocalAuth>;
  @useResult
  $Res call({String token, LocalUser user});

  $LocalUserCopyWith<$Res> get user;
}

/// @nodoc
class _$LocalAuthCopyWithImpl<$Res, $Val extends LocalAuth>
    implements $LocalAuthCopyWith<$Res> {
  _$LocalAuthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as LocalUser,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalUserCopyWith<$Res> get user {
    return $LocalUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LocalAuthCopyWith<$Res> implements $LocalAuthCopyWith<$Res> {
  factory _$$_LocalAuthCopyWith(
          _$_LocalAuth value, $Res Function(_$_LocalAuth) then) =
      __$$_LocalAuthCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, LocalUser user});

  @override
  $LocalUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_LocalAuthCopyWithImpl<$Res>
    extends _$LocalAuthCopyWithImpl<$Res, _$_LocalAuth>
    implements _$$_LocalAuthCopyWith<$Res> {
  __$$_LocalAuthCopyWithImpl(
      _$_LocalAuth _value, $Res Function(_$_LocalAuth) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? user = null,
  }) {
    return _then(_$_LocalAuth(
      null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as LocalUser,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocalAuth implements _LocalAuth {
  _$_LocalAuth(this.token, this.user);

  factory _$_LocalAuth.fromJson(Map<String, dynamic> json) =>
      _$$_LocalAuthFromJson(json);

  @override
  final String token;
  @override
  final LocalUser user;

  @override
  String toString() {
    return 'LocalAuth(token: $token, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalAuth &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalAuthCopyWith<_$_LocalAuth> get copyWith =>
      __$$_LocalAuthCopyWithImpl<_$_LocalAuth>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocalAuthToJson(
      this,
    );
  }
}

abstract class _LocalAuth implements LocalAuth {
  factory _LocalAuth(final String token, final LocalUser user) = _$_LocalAuth;

  factory _LocalAuth.fromJson(Map<String, dynamic> json) =
      _$_LocalAuth.fromJson;

  @override
  String get token;
  @override
  LocalUser get user;
  @override
  @JsonKey(ignore: true)
  _$$_LocalAuthCopyWith<_$_LocalAuth> get copyWith =>
      throw _privateConstructorUsedError;
}

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) {
  return _LocalUser.fromJson(json);
}

/// @nodoc
mixin _$LocalUser {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalUserCopyWith<LocalUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalUserCopyWith<$Res> {
  factory $LocalUserCopyWith(LocalUser value, $Res Function(LocalUser) then) =
      _$LocalUserCopyWithImpl<$Res, LocalUser>;
  @useResult
  $Res call({String email, String name, String uuid});
}

/// @nodoc
class _$LocalUserCopyWithImpl<$Res, $Val extends LocalUser>
    implements $LocalUserCopyWith<$Res> {
  _$LocalUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? uuid = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocalUserCopyWith<$Res> implements $LocalUserCopyWith<$Res> {
  factory _$$_LocalUserCopyWith(
          _$_LocalUser value, $Res Function(_$_LocalUser) then) =
      __$$_LocalUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String name, String uuid});
}

/// @nodoc
class __$$_LocalUserCopyWithImpl<$Res>
    extends _$LocalUserCopyWithImpl<$Res, _$_LocalUser>
    implements _$$_LocalUserCopyWith<$Res> {
  __$$_LocalUserCopyWithImpl(
      _$_LocalUser _value, $Res Function(_$_LocalUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? uuid = null,
  }) {
    return _then(_$_LocalUser(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocalUser implements _LocalUser {
  _$_LocalUser(this.email, this.name, this.uuid);

  factory _$_LocalUser.fromJson(Map<String, dynamic> json) =>
      _$$_LocalUserFromJson(json);

  @override
  final String email;
  @override
  final String name;
  @override
  final String uuid;

  @override
  String toString() {
    return 'LocalUser(email: $email, name: $name, uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalUser &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, name, uuid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalUserCopyWith<_$_LocalUser> get copyWith =>
      __$$_LocalUserCopyWithImpl<_$_LocalUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocalUserToJson(
      this,
    );
  }
}

abstract class _LocalUser implements LocalUser {
  factory _LocalUser(final String email, final String name, final String uuid) =
      _$_LocalUser;

  factory _LocalUser.fromJson(Map<String, dynamic> json) =
      _$_LocalUser.fromJson;

  @override
  String get email;
  @override
  String get name;
  @override
  String get uuid;
  @override
  @JsonKey(ignore: true)
  _$$_LocalUserCopyWith<_$_LocalUser> get copyWith =>
      throw _privateConstructorUsedError;
}
