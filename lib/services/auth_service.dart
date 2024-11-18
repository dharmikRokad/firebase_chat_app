import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService() => _instance;

  final GoTrueClient   _supabaseAuth = Supabase.instance.client.auth;

  Future<User?> signIn(
      {required String email, required String password}) async {
    final userCred = await _supabaseAuth.signInWithPassword(
      email: email,
      password: password,
    );
    return userCred.user;
  }

  Stream<AuthState?> authStateChanges() => _supabaseAuth.onAuthStateChange;

  Future<void> signOut() async => await _supabaseAuth.signOut();
}
