import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final String token;
  final String type; // Bearer
  final int userId;
  final String email;
  final String role;

  AuthResponse({
    required this.token,
    required this.type,
    required this.userId,
    required this.email,
    required this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
