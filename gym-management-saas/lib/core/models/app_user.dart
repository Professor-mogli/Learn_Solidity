enum UserRole { superAdmin, gymOwner, member }

class AppUser {
  final String id;
  final String name;
  final UserRole role;
  final String gymId;

  const AppUser({
    required this.id,
    required this.name,
    required this.role,
    required this.gymId,
  });
}
