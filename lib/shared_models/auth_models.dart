part of webdashboard_models;

@freezed
class LocalAuth with _$LocalAuth {
  factory LocalAuth(
    String token,
    LocalUser user,
  ) = _LocalAuth;

  factory LocalAuth.fromJson(Map<String, dynamic> json) =>
      _$LocalAuthFromJson(json);
}

@freezed
class LocalUser with _$LocalUser {
  factory LocalUser(
    String email,
    String name,
    String uuid,
  ) = _LocalUser;

  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      _$LocalUserFromJson(json);
}
