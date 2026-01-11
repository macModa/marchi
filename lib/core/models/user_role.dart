enum UserRole {
  client('CLIENT'),
  artisan('ARTISAN'),
  admin('ADMIN');

  final String value;
  const UserRole(this.value);

  static UserRole fromString(String role) {
    switch (role.toUpperCase()) {
      case 'CLIENT':
        return UserRole.client;
      case 'ARTISAN':
        return UserRole.artisan;
      case 'ADMIN':
        return UserRole.admin;
      default:
        throw ArgumentError('Invalid role: $role');
    }
  }

  String toJson() => value;
}
