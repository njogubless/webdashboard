part of webdashboard_models;

@freezed
class WDValidationError with _$WDValidationError {
  factory WDValidationError(
    int code,
    List<WDFieldValidationError> errors,
  ) = _WDValidationError;

  factory WDValidationError.fromJson(Map<String, dynamic> json) =>
      _$WDValidationErrorFromJson(json);
}

@freezed
class WDFieldValidationError with _$WDFieldValidationError {
  factory WDFieldValidationError(
    String key,
    List<String> errors,
  ) = _WDFieldValidationError;

  factory WDFieldValidationError.fromJson(Map<String, dynamic> json) =>
      _$WDFieldValidationErrorFromJson(json);
}

class Failure implements Exception {
  Failure({
    required this.message,
    this.errors = const [],
  });

  final String message;
  List<WDFieldValidationError> errors;

  @override
  String toString() {
    return 'Failure: $message';
  }
}
