import 'package:supabase_flutter/supabase_flutter.dart';

class SupaAuthService {
  SupaAuthService._();

  static final SupaAuthService _instance = SupaAuthService._();

  factory SupaAuthService() => _instance;

  final GoTrueClient _supabaseAuth = Supabase.instance.client.auth;

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
