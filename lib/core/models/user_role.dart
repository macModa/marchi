enum UserRole {
  client('CLIENT'),
  artisan('ARTISAN'),
  admin('ADMIN');

  final String value;
  const UserRole(this.value);

  static UserRole fromString(String role) {
    final normalized = role.toUpperCase();
    if (normalized.contains('ARTISAN')) return UserRole.artisan;
    if (normalized.contains('CLIENT')) return UserRole.client;
    if (normalized.contains('ADMIN')) return UserRole.admin;
    throw ArgumentError('Invalid role: $role');
  }

  String toJson() => value;
}
