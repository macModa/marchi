import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String nom;
  final String email;
  final String password;
  final String? telephone;
  final String? ville;
  final String role; // ARTISAN | CLIENT
  final String? nomBoutique;
  final String? description;
  final String? adresseLivraison;

  RegisterRequest({
    required this.nom,
    required this.email,
    required this.password,
    this.telephone,
    this.ville,
    required this.role,
    this.nomBoutique,
    this.description,
    this.adresseLivraison,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
