enum UserRole { superAdmin, gymOwner, member }

class AuthContext {
  final String userId;
  final String? gymId;
  final UserRole role;
  final bool isGymActive;

  const AuthContext({
    required this.userId,
    required this.gymId,
    required this.role,
    required this.isGymActive,
  });
}

class AuthGuard {
  static void ensureRole(AuthContext ctx, List<UserRole> allowedRoles) {
    if (!allowedRoles.contains(ctx.role)) {
      throw StateError('Access denied: insufficient role');
    }
  }

  static void ensureTenantScope(AuthContext ctx, String targetGymId) {
    if (ctx.role == UserRole.superAdmin) return;
    if (ctx.gymId == null || ctx.gymId != targetGymId) {
      throw StateError('Access denied: tenant mismatch');
    }
  }

  static void ensureGymIsActive(AuthContext ctx) {
    if (!ctx.isGymActive) {
      throw StateError('Access denied: gym is inactive');
    }
  }
}
