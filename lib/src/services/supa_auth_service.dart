import 'package:chat_app/src/chat_app_injector.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaAuthService {
  SupaAuthService._();

  static final SupaAuthService _instance = SupaAuthService._();

  factory SupaAuthService() => _instance;

  final GoTrueClient _supabaseAuth = sl<Supabase>().client.auth;

  Future<User?> signIn(
      {required String email, required String password}) async {
    final userCred = await _supabaseAuth.signInWithPassword(
      email: email,
      password: password,
    );
    return userCred.user;
  }

  Future<bool> sendOtp(String phone) async {
    await _supabaseAuth.signInWithOtp(phone: phone);
    return true;
  }

  Future<AuthResponse> verifyOtp(String phone, String otp) async {
    final res = await _supabaseAuth.verifyOTP(phone: phone, token: otp, type: OtpType.sms);
    return res;
  }

  Stream<AuthState?> authStateChanges() => _supabaseAuth.onAuthStateChange;

  Future<void> signOut() async => await _supabaseAuth.signOut();

  User? get getCurrentUser => _supabaseAuth.currentUser;

  Session? get currentSession => _supabaseAuth.currentSession;
}
