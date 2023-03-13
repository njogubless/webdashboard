// GENERATED CODE - DO NOT MODIFY BY HAND

part of webdashboard_models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WDValidationError _$$_WDValidationErrorFromJson(Map<String, dynamic> json) =>
    _$_WDValidationError(
      json['code'] as int,
      (json['errors'] as List<dynamic>)
          .map(
              (e) => WDFieldValidationError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_WDValidationErrorToJson(
        _$_WDValidationError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'errors': instance.errors,
    };

_$_WDFieldValidationError _$$_WDFieldValidationErrorFromJson(
        Map<String, dynamic> json) =>
    _$_WDFieldValidationError(
      json['key'] as String,
      (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_WDFieldValidationErrorToJson(
        _$_WDFieldValidationError instance) =>
    <String, dynamic>{
      'key': instance.key,
      'errors': instance.errors,
    };

_$_LocalAuth _$$_LocalAuthFromJson(Map<String, dynamic> json) => _$_LocalAuth(
      json['token'] as String,
      LocalUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LocalAuthToJson(_$_LocalAuth instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

_$_LocalUser _$$_LocalUserFromJson(Map<String, dynamic> json) => _$_LocalUser(
      json['email'] as String,
      json['name'] as String,
      json['uuid'] as String,
    );

Map<String, dynamic> _$$_LocalUserToJson(_$_LocalUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'uuid': instance.uuid,
    };
