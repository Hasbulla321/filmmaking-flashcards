/// Stub for future authentication.
/// When auth is needed, implement FirebaseAuthService
/// and swap it in via Provider.
abstract class AuthService {
  String? get currentUserId;
  bool get isSignedIn;
  Future<void> signIn();
  Future<void> signOut();
}
